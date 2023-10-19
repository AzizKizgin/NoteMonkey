//
//  NoteItemBackground.swift
//  ANote
//
//  Created by Aziz Kızgın on 8.10.2023.
//

import SwiftUI

struct NoteItemBackground: ViewModifier {
    let id: String
    let isFullScreen: Bool
    func body(content: Content) -> some View {
        content
            .background{
                VStack{
                    if id == "0" {
                        isFullScreen ? Color.default: Color.note
                    }
                    else if let image = Backgrounds.backgrounds.first(where: {$0.id == id})?.image{
                        if isFullScreen{
                            Image(image)
                                .resizable(resizingMode: .stretch)
                                .scaledToFill()
                        }
                        else{
                            Image(image)
                                .resizable(resizingMode: .tile)
                        }
                    }
                    else if let color = Backgrounds.backgrounds.first(where: {$0.id == id})?.color{
                        Color(hex: color)
                    }
                }
                .ignoresSafeArea()
                
                .animation(.easeInOut(duration: 0.3), value: id)
            }
    }
}

extension View {
    func noteItemBackground(with id: String, isFullScreen: Bool) -> some View {
        modifier(NoteItemBackground(id: id,isFullScreen: isFullScreen))
    }
}

#Preview {
    VStack{
        Text("s")
            .frame(maxWidth: /*@START_MENU_TOKEN@*/.infinity/*@END_MENU_TOKEN@*/,maxHeight: .infinity)
    }
    .noteItemBackground(with: "0",isFullScreen: false)
}

