//
//  DeletedNotesView.swift
//  ANote
//
//  Created by Aziz Kızgın on 18.10.2023.
//

import SwiftUI
import SwiftData

struct DeletedNotesView: View {
    @Environment(\.modelContext) private var modelContext
    @Query(filter: #Predicate<Note>{ note in
        note.isDeleted == true && (note.title != "" || note.content != "")
    } ,sort: [SortDescriptor(\Note.deletedAt, order: .reverse)]
           ,  animation: .smooth(duration: 0.3)
    ) private var notes: [Note]
  
    @State var searchText: String = ""
    @State var showSelectionMenu: Bool = false
    @State var scrollOffset: CGFloat = 0.00
    @State var selectedNotes: [String] = []
    @State var isListView: Bool = true
    @State var showList: Bool = true
    
    var filteredNotes: [Note] {
        guard !searchText.isEmpty else {return notes}
        return notes.filter{$0.content.contains(searchText) || $0.title.contains(searchText)}
    }
    
    var body: some View {
        VStack{
            DeletedNotesMenu(showSelectionMenu: showSelectionMenu, selectedItemCount: selectedNotes.count, onCancelSelect: onCancelPress, onSelectAll: onSelectAll, onChangeListType: onChangeListType)
            if  !showSelectionMenu {
                SearchBar(text: $searchText, placeHolder: "Search Notes...")
            }
            ScrollView{
                if showList {
                    Group{
                        if isListView{
                            LazyVStack{
                                ForEach(filteredNotes, id: \.id.uuidString){ item in
                                    NoteListItem(note: item,
                                                 onLongPress:{
                                        onItemLongPress(id:item.id.uuidString)
                                    },
                                                 showSelectButton: showSelectionMenu,
                                                 isSelected: selectedNotes.contains(item.id.uuidString),
                                                 isListView: isListView
                                    )
                                }
                            }
                            .padding(.horizontal, isListView ? 20 : 0)
                            .transition(.move(edge: .leading).combined(with: .opacity))
                        }
                        else{
                            LazyVGrid(columns: [GridItem(.adaptive(minimum: 160))]){
                                ForEach(filteredNotes, id: \.id.uuidString){ item in
                                    NoteListItem(note: item,
                                                 onLongPress:{
                                        onItemLongPress(id:item.id.uuidString)
                                    },
                                                 showSelectButton: showSelectionMenu,
                                                 isSelected: selectedNotes.contains(item.id.uuidString),
                                                 isListView: isListView
                                    )
                                }
                            }
                            .padding(.horizontal, 20)
                            .transition(.move(edge: .trailing).combined(with: .opacity))
                        }
                    }
           
                }
            }
        }
        .overlay(alignment: .bottom){
            if showSelectionMenu && selectedNotes.count > 0 {
                DeletedNotesBottomBar(onUnDelete: onUnDelete, deleteSelectedNotes: deleteSelectedNotes, selectedItemCount: selectedNotes.count)
            }
        }
        .background(Color.default)
        .animation(.easeInOut(duration: 0.2),value: selectedNotes)
        .animation(.easeInOut(duration: 0.5),value: isListView)
        .animation(.easeInOut(duration: 0.2),value: showSelectionMenu)
        .transition(.move(edge: .bottom).combined(with: .opacity))
        .ignoresSafeArea(edges:.bottom)
    }
}

extension DeletedNotesView{
    private func onItemLongPress(id:String){
        if selectedNotes.contains(id){
            selectedNotes = selectedNotes.filter(){$0 != id}
        }
        else{
            selectedNotes.append(id)
            showSelectionMenu = true
        }
    }
    
    private func onCancelPress(){
        selectedNotes.removeAll()
        showSelectionMenu = false
    }
    
    private func onSelectAll(){
        if selectedNotes.count == filteredNotes.count{
            selectedNotes.removeAll()
        }
        else{
            selectedNotes = filteredNotes.map({$0.id.uuidString})
        }
    }
    
    private func onChangeListType(){
        isListView.toggle()
    }
    
    private func deleteSelectedNotes(){
        for index in selectedNotes {
            if let noteToDelete = filteredNotes.first(where: {$0.id.uuidString == index}){
                modelContext.delete(noteToDelete)
            }
        }
        selectedNotes.removeAll()
        showSelectionMenu.toggle()
    }
    
    private func onUnDelete(){
        for index in selectedNotes {
            if let noteToUnDelete = filteredNotes.first(where: {$0.id.uuidString == index}){
                noteToUnDelete.isDeleted = false
                noteToUnDelete.deletedAt = nil
                try! modelContext.save()
            }
        }
        selectedNotes.removeAll()
        showSelectionMenu.toggle()
    }
}

#Preview {
    MainActor.assumeIsolated{
        let config = ModelConfiguration(isStoredInMemoryOnly: true)
        let container = try! ModelContainer(for: NoteBackground.self, Note.self, configurations: config)

        let background = NoteBackground(id: "2", image: "bird",createdAt: Date.now.addingTimeInterval(2*100))
        container.mainContext.insert(background)
        
        for _ in 0...10 {
            let note = Note(
                title: "Note Title",
                content: "Lorem ipsum dolor sit amet",
                createdAt: Date(),
                isDeleted: true,
                deletedAt: .now.addingTimeInterval(10)
            )
            note.background = background
            container.mainContext.insert(note)
        }
        
        return
            NavigationStack{
                DeletedNotesView()
        }
        .modelContainer(container)
    }
}

