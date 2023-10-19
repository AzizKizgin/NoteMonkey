//
//  SearchBar.swift
//  ANote
//
//  Created by Aziz Kızgın on 18.10.2023.
//

import SwiftUI

struct SearchBar: View {
    @Binding var text: String
    let placeHolder:String?
    var body: some View {
        VStack{
            HStack{
                Image(systemName: "magnifyingglass")
                    .foregroundStyle(.white.opacity(0.6))
                TextField(text: $text){
                    Text(placeHolder ?? "Search...")
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
        .padding(.horizontal,25)
        .transition(.move(edge: .top).combined(with: .opacity))
    }
}

#Preview {
    SearchBar(text: .constant("Search"), placeHolder: "Search note")
}
