//
//  NoteItemBackground.swift
//  ANote
//
//  Created by Aziz Kızgın on 8.10.2023.
//

import SwiftUI

struct NoteItemBackground: ViewModifier {
    let index: Int
    func body(content: Content) -> some View {
        content
            .background{
                VStack{
                    if index == 0 {
                        Color("default")
                    }
                    else if let image = Backgrounds.backgrounds[index].image{
                        Image(image)
                            .resizable()
                    }
                    else if let color = Backgrounds.backgrounds[index].color{
                        Color(hex: color)
                    }
                }
                .ignoresSafeArea()
                .scaledToFill()
                .animation(.easeInOut(duration: 0.3), value: index)
            }
    }
}

extension View {
    func noteItemBackground(with index: Int) -> some View {
        modifier(NoteItemBackground(index: index))
    }
}

#Preview {
    VStack{
        Text("asdasd")
            .frame(maxWidth: /*@START_MENU_TOKEN@*/.infinity/*@END_MENU_TOKEN@*/,maxHeight: .infinity)
    }
    .noteItemBackground(with: 0)
}

