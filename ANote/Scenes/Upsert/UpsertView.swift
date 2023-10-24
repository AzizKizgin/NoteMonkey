//
//  UpsertView.swift
//  ANote
//
//  Created by Aziz Kızgın on 10.10.2023.
//

import SwiftUI

struct UpsertView: View {
    @Environment(\.modelContext) private var modelContext
    @Environment(\.dismiss) var dismiss
    let note: Note?
    @State private var title: String = ""
    @State private var content: String = "sadasdasfsdf sd"
    @State private var showBackgroundList: Bool = false
    @State private var selectedBackground: NoteBackground = NoteBackground(id: "0", textColor: "text")
    @FocusState private var isFocused
    
    init(note: Note? = nil) {
        self.note = note
    }
    var body: some View {
        NavigationStack{
            VStack{
                VStack{
                    TextField("", text: $title, prompt: Text("Title")
                        .foregroundStyle(Color(hex:selectedBackground.textColor).opacity(0.5))
                        .bold())
                    .foregroundStyle(Color(hex: selectedBackground.textColor))
                    .font(.title)
                    .bold()
                    ContentEditor(text: $content,isFocused: isFocused, textColor:Color(hex:selectedBackground.textColor))
                        .focused($isFocused)
                }
                .padding()
                .onTapGesture {
                    showBackgroundList = false
                }
            }
            .backgroundPickerList(with: $selectedBackground, isVisible: showBackgroundList)
            .noteItemBackground(with: selectedBackground.id ,isFullScreen: true)
            .animation(.easeIn(duration: 0.2), value: showBackgroundList)
            .frame(maxHeight: .infinity,alignment: .top)
            .foregroundStyle(.white)
            .ignoresSafeArea(.keyboard)
            .toolbar{
                ToolbarItem(placement:.topBarTrailing){
                    HStack(spacing:20){
                        ShareNoteButton(title: title, content: content)
                        MenuButton(iconName: "paintbrush", onPress: toggleBackgroundList, size: 20)
                        MenuButton(iconName: "trash", onPress: onDelete, size: 20)
                    }
                    .foregroundStyle(Color(hex:selectedBackground.textColor))
                    .padding(.horizontal)
                }
            }
            .onAppear{
                self.title = note?.title ?? ""
                self.content = note?.content ?? ""
                self.selectedBackground = note?.background ?? NoteBackground(id: "0", textColor: "text")
            }
        }
    }
}

extension UpsertView{
    private func toggleBackgroundList(){
        showBackgroundList.toggle()
    }
    
    private func onDelete(){
        let note = Note(id:UUID(),title: title,content: content,createdAt: .now)
        note.background = selectedBackground
        modelContext.insert(note)
      
    }
    
    private func onShare(){
        
    }
}

#Preview {
    UpsertView()
}
