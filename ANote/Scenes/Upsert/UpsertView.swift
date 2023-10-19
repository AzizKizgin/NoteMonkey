//
//  UpsertView.swift
//  ANote
//
//  Created by Aziz Kızgın on 10.10.2023.
//

import SwiftUI

struct UpsertView: View {
    let note: Note?
    @State private var title: String = ""
    @State private var content: String = "sadasdasfsdf sd"
    @State private var showBackgroundList: Bool = false
    @State private var selectedBackground: String = "0"
    @State private var textColor: String = "text"
    @FocusState private var isFocused
    
    init(note: Note? = nil) {
        self.note = note
    }
    var body: some View {
        NavigationStack{
            VStack{
                VStack{
                    TextField("", text: $title, prompt: Text("Title")
                        .foregroundStyle(Color(hex:textColor).opacity(0.5))
                        .bold())
                    .foregroundStyle(Color(hex: textColor))
                    .font(.title)
                    .bold()
                    ContentEditor(text: $content,isFocused: isFocused, textColor:Color(hex:textColor))
                        .focused($isFocused)
                }
                .padding()
                .onTapGesture {
                    showBackgroundList = false
                }
            }
            .backgroundPickerList(with: $selectedBackground, isVisible: showBackgroundList)
            .animation(.easeIn(duration: 0.2), value: showBackgroundList)
            .frame(maxHeight: .infinity,alignment: .top)
            .foregroundStyle(.white)
            .noteItemBackground(with: selectedBackground,isFullScreen: true)
            .ignoresSafeArea(.keyboard)
            .toolbar{
                ToolbarItem(placement:.topBarTrailing){
                    HStack(spacing:20){
                        ShareNoteButton(title: title, content: content)
                        MenuButton(iconName: "paintbrush", onPress: toggleBackgroundList, size: 20)
                        MenuButton(iconName: "trash", onPress: onDelete, size: 20)
                    }
                    .foregroundStyle(Color(hex:textColor))
                    .padding(.horizontal)
                }
            }
            .onChange(of: selectedBackground){ _ , newIndex in
                textColor = Backgrounds.backgrounds.first(where: {$0.id == selectedBackground})?.textColor ?? "text"
            }
            .onAppear{
                self.title = note?.title ?? ""
                self.content = note?.content ?? ""
                self.selectedBackground = note?.background?.id ?? "2"
            }
        }
    }
}

extension UpsertView{
    private func toggleBackgroundList(){
        showBackgroundList.toggle()
    }
    
    private func onDelete(){
        
    }
    
    private func onShare(){
        
    }
}

#Preview {
    UpsertView()
}
