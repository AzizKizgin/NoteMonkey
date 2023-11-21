//
//  HomeView.swift
//  NoteMonkey
//
//  Created by Aziz Kızgın on 15.10.2023.
//

import SwiftUI
import SwiftData

struct HomeView: View {
    @Environment(\.modelContext) private var modelContext
    @Query(filter: #Predicate<Note>{ note in
        note.isDeleted == false && (note.title != "" || note.content != "")
    } ,sort: [SortDescriptor(\Note.isPinned, order: .reverse),SortDescriptor(\Note.createdAt, order: .reverse)]
           ,  animation: .smooth(duration: 0.3)
    ) private var notes: [Note]
    @State var searchText: String = ""
    @State var showSelectionMenu: Bool = false
    @State var selectedNotes: [String] = []
    @State var isListView: Bool = true
    @State var showList: Bool = true
    @FocusState var isFocused 

    var filteredNotes: [Note] {
        guard !searchText.isEmpty else {return notes}
        return notes.filter{$0.content.contains(searchText) || $0.title.contains(searchText)}
    }
    
    var body: some View {
        VStack{
            if !isFocused{
                HomeMenu(
                    showSelectionMenu: showSelectionMenu,
                    selectedItemCount: selectedNotes.count,
                    onCancelSelect: onCancelPress,
                    onSelectAll: onSelectAll,
                    onChangeListType: onChangeListType
                )
                .transition(.move(edge: .top).combined(with: .opacity))
            }
            if !showSelectionMenu {
                SearchBar(text: $searchText, placeHolder: "Search Notes...")
                    .focused($isFocused)
            }
            ScrollView{
                if showList {
                    Group{
                        if isListView{
                            LazyVStack{
                                ForEach(filteredNotes, id: \.id.uuidString){item in
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
                                        onItemLongPress(id:String(item.id.uuidString))
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
            .safeAreaPadding(.bottom,70)
            .overlay(alignment: .bottomTrailing){
                !showSelectionMenu ? AddFabButton()
                :nil
            }
            .overlay(alignment: .bottom){
                if showSelectionMenu && selectedNotes.count > 0 {
                    HStack(spacing:0){
                        Button(action: pinSelectedNotes) {
                            Image(systemName: "pin")
                                .font(.system(size: 25))
                                .frame(maxWidth: .infinity)
                        }
                        Button(action: deleteSelectedNotes) {
                            Image(systemName: "trash")
                                .font(.system(size: 25))
                                .frame(maxWidth: .infinity)
                        }
                    }
                    .frame(maxWidth: .infinity)
                    .safeAreaPadding(20)
                    .background(.default)
                    .transition(.move(edge: .bottom).combined(with: .opacity))
                }
            }
        }
        .animation(.easeInOut(duration: 0.2),value: selectedNotes)
        .animation(.easeInOut(duration: 0.5),value: isListView)
        .animation(.easeInOut(duration: 0.2),value: showSelectionMenu)
        .animation(.easeInOut,value: isFocused)
        .ignoresSafeArea(edges:.bottom)
        .background(Color.default)
    }
}

extension HomeView{
    private func onItemLongPress(id:String){
        if selectedNotes.contains(id){
            selectedNotes = selectedNotes.filter({$0 != id})
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
                noteToDelete.deletedAt = .now
                noteToDelete.isDeleted.toggle()
            }
        }
        selectedNotes.removeAll()
        showSelectionMenu.toggle()
    }
    
    private func pinSelectedNotes(){
        for index in selectedNotes {
            if let noteToPin = filteredNotes.first(where: {$0.id.uuidString == index}){
                noteToPin.isPinned.toggle()
            }
        }
        showSelectionMenu.toggle()
        selectedNotes.removeAll()
    }
}

#Preview {
    MainActor.assumeIsolated{
        let config = ModelConfiguration(isStoredInMemoryOnly: true)
        let container = try! ModelContainer(for: NoteBackground.self, Note.self, configurations: config)

        let background = NoteBackground(id: "2", image: "bird",createdAt: Date.now.addingTimeInterval(2*100))
        container.mainContext.insert(background)
        
        for index in 0...10 {
            let note = Note(
                title: "Note Title",
                content: "Lorem ipsum dolor sit amet",
                createdAt: Date()
            )
            if index % 2 == 0 {
                note.isPinned = 1
            }
            note.background = background
            container.mainContext.insert(note)
        }
        
        return
            NavigationStack{
            HomeView()
        }
        .modelContainer(container)
    }

}

