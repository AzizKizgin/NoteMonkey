//
//  HomeView.swift
//  ANote
//
//  Created by Aziz Kızgın on 15.10.2023.
//

import SwiftUI

struct HomeView: View {
    @State var text: String = ""
    @State var showFab: Bool = true
    @State var scrollOffset: CGFloat = 0.00
    @State var selectedNotes: [String] = []
    var body: some View {
        VStack{
            Text(selectedNotes.joined())
                .foregroundStyle(.black)
            if selectedNotes.isEmpty{
                HomeMenu()
                    .transition(.move(edge: .top).combined(with: .opacity))
            }
            if showFab && selectedNotes.isEmpty {
                VStack{
                    HStack{
                        Image(systemName: "magnifyingglass")
                            .foregroundStyle(.white.opacity(0.6))
                        TextField(text: $text){
                            Text("sdsad")
                                .foregroundStyle(.white.opacity(0.6))
                        }
                        .font(.system(size: 19))
                        .foregroundStyle(.white)
                    }
                    .padding(.horizontal,20)
                    .padding(.vertical,13)
                    .background(Color.accentColor.opacity(0.6))
                    .clipShape(.capsule)
                }
                .transition(.move(edge: .top).combined(with: .opacity))
            }
            ScrollView{
                LazyVStack{
                    ForEach(1...100, id: \.self){ item in
                        NoteListItem(note: Note(title: "s", content: "s", createdAt: Date()),
                                     onLongPress:{
                            onItemLongPress(id:String(item))
                        },
                                     showSelectButton: !selectedNotes.isEmpty,
                                     isSelected: selectedNotes.contains(String(item))
                        )
                    }
                }
              
                .background(GeometryReader {
                    return Color.clear.preference(key: ViewOffsetKey.self,
                                                  value: -$0.frame(in: .named("scroll")).origin.y)
                })
            }
            .onPreferenceChange(ViewOffsetKey.self) { offset in
                withAnimation {
                    if offset > 50 {
                        showFab = offset < scrollOffset
                    } else  {
                        showFab = true
                    }
                }
                scrollOffset = offset
            }
            .coordinateSpace(name: "scroll")
            .overlay(alignment: .bottomTrailing){
                showFab ? Button(action: {}, label: {
                    Image(systemName: "plus")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 20)
                        .padding()
                })
                .buttonStyle(.borderedProminent)
                .buttonBorderShape(.circle)
                .padding(.vertical,10)
                .transition(.scale)
                :nil
                
            }
        }
        .animation(.easeInOut(duration: 0.2),value: selectedNotes)
        .padding()
        .ignoresSafeArea(edges:.bottom)
    }
}

struct ViewOffsetKey: PreferenceKey {
    typealias Value = CGFloat
    static var defaultValue = CGFloat.zero
    static func reduce(value: inout Value, nextValue: () -> Value) {
        value += nextValue()
    }
}

extension HomeView{
    private func onItemLongPress(id:String){
        if selectedNotes.contains(id){
            selectedNotes = selectedNotes.filter(){$0 != id}
        }
        else{
            selectedNotes.append(id)
        }
    }
}

#Preview {
    NavigationStack{
        HomeView()
    }
}
