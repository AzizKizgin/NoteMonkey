//
//  UpsertView.swift
//  ANote
//
//  Created by Aziz Kızgın on 10.10.2023.
//

import SwiftUI

struct UpsertView: View {
    @State private var title: String = ""
    @State private var content: String = "sadasdasfsdf sd"
    @State private var showBackgroundList: Bool = true
    @State private var selectedBackground: String = "0"
    @State private var textColor: String = "item"
    
    @FocusState private var isFocused 
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
            .backgroundPickerList(with: $selectedBackground)
            .animation(.easeIn(duration: 0.2), value: showBackgroundList)
            .frame(maxHeight: .infinity,alignment: .top)
            .foregroundStyle(.white)
            .noteItemBackground(with: selectedBackground,isFullScreen: true)
            .ignoresSafeArea(.keyboard)
            .toolbar{
                ToolbarItem(placement:.topBarTrailing){
                    HStack(spacing:20){
                        Image(systemName: "square.and.arrow.up")
                        Image(systemName: "paintbrush")
                            .onTapGesture {
                                showBackgroundList.toggle()
                            }
                        Image(systemName: "trash")
                    }
                    .foregroundStyle(Color(hex:textColor))
                    .padding(.horizontal)
                }
            }
            .onChange(of: selectedBackground){ _ , newIndex in
                textColor = Backgrounds.backgrounds.first(where: {$0.id == selectedBackground})?.textColor ?? "item"
            }
        }
    }
    
}

#Preview {
    UpsertView()
}
