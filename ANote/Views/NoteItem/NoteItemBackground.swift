//
//  NoteItemBackground.swift
//  ANote
//
//  Created by Aziz Kızgın on 8.10.2023.
//

import SwiftUI

struct NoteItemBackground: ViewModifier {
    let background: NoteBackground
    func body(content: Content) -> some View {
        content
            .background{
                if let image = background.image{
                    Image(image)
                        .resizable()
                        .scaledToFill()
                }
                else if let color = background.color{
                    getBackgroundColor(color: color)
                }
            }
    }
}

extension View {
    func noteItemBackground(with background: NoteBackground) -> some View {
        modifier(NoteItemBackground(background: background))
    }
}

#Preview {
    VStack{
        Text("asdasd")
    }
        .noteItemBackground(with: NoteBackground.bengal)
}

func getBackgroundColor(color: String) -> some View{
    switch color {
    case "blue":
        return Color.blue
    case "red":
        return Color.red
    case "yellow":
        return Color.yellow
    case "pink":
        return Color.pink
    case "purple":
        return Color.purple
    case "orange":
        return Color.orange
    case "brown":
        return Color.brown
    case "mint":
        return Color.mint
    default:
        return Color.gray
    }
}
