//
//  HomeView.swift
//  ANote
//
//  Created by Aziz Kızgın on 15.10.2023.
//

import SwiftUI

struct HomeView: View {
    @State var searchText: String = ""
    @State var showFab: Bool = true
    @State var showSelectionMenu: Bool = false
    @State var scrollOffset: CGFloat = 0.00
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
            .padding(.vertical,5)
            .padding(.horizontal)
            .transition(.move(edge: .top).combined(with: .opacity))
            if showFab && !showSelectionMenu {
                SearchBar(text: $searchText, placeHolder: "Search Notes...")
            }
            ScrollView{
                if showList {
                    Group{
                        if isListView{
                            LazyVStack{
                                ForEach(1...10, id: \.self){ item in
                                    NoteListItem(note: Note(id: UUID(),title: "s", content: "s", createdAt: Date()),
                                                 onLongPress:{
                                        onItemLongPress(id:String(item))
                                    },
                                                 showSelectButton: showSelectionMenu,
                                                 isSelected: selectedNotes.contains(String(item)),
                                                 isListView: isListView
                                    )
                                }
                            }
                            .padding(.horizontal, isListView ? 20 : 0)
                            .transition(.move(edge: .leading).combined(with: .opacity))
                            .transition(.identity.combined(with: .opacity))
                        }
                        else{
                            LazyVGrid(columns: [GridItem(.adaptive(minimum: 160))]){
                                ForEach(1...10, id: \.self){ item in
                                    NoteListItem(note: Note(id: UUID(),title: "s", content: "s", createdAt: Date()),
                                                 onLongPress:{
                                        onItemLongPress(id:String(item))
                                    },
                                                 showSelectButton: showSelectionMenu,
                                                 isSelected: selectedNotes.contains(String(item)),
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
            .coordinateSpace(name: "scroll")
            .overlay(alignment: .bottomTrailing){
                !showSelectionMenu && showFab ? Button(action: {}, label: {
                    Image(systemName: "plus")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 20)
                        .padding()
                })
                .buttonStyle(.borderedProminent)
                .buttonBorderShape(.circle)
                .padding(.vertical,30)
                .padding(.horizontal)
                :nil
                
            }
        }
        .animation(.easeInOut(duration: 0.2),value: selectedNotes)
        .animation(.easeInOut(duration: 0.5),value: isListView)
        .ignoresSafeArea(edges:.bottom)
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
        if selectedNotes.count == 100{
            selectedNotes.removeAll()
        }
        else{
            selectedNotes = Array(0...99).map{String($0)}
        }
    }
    
    private func onChangeListType(){
        isListView.toggle()
    }
}

#Preview {
    NavigationStack{
        HomeView()
    }
}

