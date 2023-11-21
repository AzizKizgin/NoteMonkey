//
//  SearchBar.swift
//  NoteMonkey
//
//  Created by Aziz Kızgın on 18.10.2023.
//

import SwiftUI

struct SearchBar: View {
    @Binding var text: String
    let placeHolder:String?
    @FocusState var isFocused
    var body: some View {
       HStack{
            HStack{
                Image(systemName: "magnifyingglass")
                TextField(text: $text){
                    Text(placeHolder ?? "Search...")
                        .foregroundStyle(.white.opacity(0.6))
                }
                .focused($isFocused)
                .font(.system(size: 16))
                if !text.isEmpty {
                    Image(systemName: "multiply")
                        .onTapGesture {
                            text = ""
                        }
                }
            }
            .foregroundStyle(.white)
            .padding(.horizontal,20)
            .padding(.vertical,10)
            .background(Color.accentColor.opacity(0.6))
            .clipShape(RoundedRectangle(cornerSize: CGSize(width: 15, height: 15)))
           if isFocused{
               Button(action: {isFocused.toggle()}, label: {
                   Text("Done")
                       .font(.system(size: 20))
                       .foregroundStyle(Color.accentColor)
               })
               .buttonStyle(.plain)
           }
        }
        .padding(.horizontal,25)
        .transition(.move(edge: .top).combined(with: .opacity))
    }
}

#Preview {
    SearchBar(text: .constant(""), placeHolder: "Search note")
}
