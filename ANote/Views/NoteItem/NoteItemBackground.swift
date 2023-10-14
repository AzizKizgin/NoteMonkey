//
//  NoteItemBackground.swift
//  ANote
//
//  Created by Aziz Kızgın on 8.10.2023.
//

import SwiftUI

struct NoteItemBackground: ViewModifier {
    let id: String
    func body(content: Content) -> some View {
        content
            .background{
                VStack{
                    if id == "0" {
                        Color("default")
                    }
                    else if let image = Backgrounds.backgrounds.first(where: {$0.id == id})?.image{
                        Image(image)
                            .resizable()
                    }
                    else if let color = Backgrounds.backgrounds.first(where: {$0.id == id})?.color{
                        Color(hex: color)
                    }
                }
                .ignoresSafeArea()
                .scaledToFill()
                .animation(.easeInOut(duration: 0.3), value: id)
            }
    }
}

extension View {
    func noteItemBackground(with id: String) -> some View {
        modifier(NoteItemBackground(id: id))
    }
}

#Preview {
    VStack{
        Text("asdasd")
            .frame(maxWidth: /*@START_MENU_TOKEN@*/.infinity/*@END_MENU_TOKEN@*/,maxHeight: .infinity)
    }
    .noteItemBackground(with: "0")
}

