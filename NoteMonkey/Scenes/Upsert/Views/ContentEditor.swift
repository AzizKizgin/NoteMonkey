//
//  ContentEditor.swift
//  NoteMonkey
//
//  Created by Aziz Kızgın on 10.10.2023.
//

import SwiftUI

struct ContentEditor: View {
    @Binding var text: String
    let isFocused: Bool
    let textColor: Color
    
    init(text: Binding<String>, isFocused: Bool, textColor: Color = Color(hex:"#ffffff")) {
        self._text = text
        self.isFocused = isFocused
        self.textColor = textColor
    }

    var body: some View {
        TextEditor(text: $text)
            .scrollContentBackground(.hidden)
            .foregroundStyle(textColor)
            .background(.clear)
            .font(.title3)
            .autocorrectionDisabled()
            .background{
                if(!isFocused && text.isEmpty){
                    Text("Start to write")
                        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .topLeading)
                        .font(.title3)
                        .padding(.top,8)
                        .padding(.leading,5)
                        .foregroundStyle(textColor.opacity(0.5))
                }
            }
    }
}

#Preview {
    ContentEditor(text: .constant(""),isFocused: false, textColor: .red)
}
