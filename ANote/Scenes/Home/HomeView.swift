//
//  HomeView.swift
//  ANote
//
//  Created by Aziz Kızgın on 15.10.2023.
//

import SwiftUI
import SwiftData

struct HomeView: View {
    @Environment(\.modelContext) private var modelContext
    @Query(filter: #Predicate<Note>{$0.isDeleted == false} ,sort: [SortDescriptor(\Note.isPinned),SortDescriptor(\Note.createdAt, order: .reverse)]) private var notes: [Note]
    @State var searchText: String = ""
    @State var showSelectionMenu: Bool = false
    @State var selectedNotes: [String] = []
    @State var isListView: Bool = true
    @State var showList: Bool = true

    var body: some View {
        VStack{
            HomeMenu(
                showSelectionMenu: showSelectionMenu,
                selectedItemCount: selectedNotes.count,
                onCancelSelect: onCancelPress,
                onSelectAll: onSelectAll,
                onChangeListType: onChangeListType
            )
            if !showSelectionMenu {
                SearchBar(text: $searchText, placeHolder: "Search Notes...")
            }
            ScrollView{
                if showList {
                    Group{
                        if isListView{
                            LazyVStack{
                                ForEach(notes, id: \.id.uuidString){item in
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
                                ForEach(notes, id: \.id.uuidString){ item in
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
        .ignoresSafeArea(edges:.bottom)
        .background(Color.default)
    }
}

extension HomeView{
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
        if selectedNotes.count == notes.count{
            selectedNotes.removeAll()
        }
        else{
            selectedNotes = notes.map({$0.id.uuidString})
        }
    }
    
    private func onChangeListType(){
        isListView.toggle()
    }
    
    private func deleteSelectedNotes(){
        do{
            for index in selectedNotes {
                if let noteToDelete = notes.first(where: {$0.id.uuidString == index}){
                    noteToDelete.isDeleted = true
                }
            }
            try modelContext.save()
            selectedNotes.removeAll()
        }
        catch{
            
        }
    }
    
    private func pinSelectedNotes(){
        
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

