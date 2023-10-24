//
//  NoteItemBackground.swift
//  ANote
//
//  Created by Aziz Kızgın on 8.10.2023.
//

import SwiftUI
import SwiftData

struct NoteItemBackground: ViewModifier {
    @Query var backgrounds: [NoteBackground]
    let id: String
    let isFullScreen: Bool
    func body(content: Content) -> some View {
        content
            .background{
                VStack{
                    if id == "0" {
                        isFullScreen ? Color.default: Color.note
                    }
                    else if let image = backgrounds.first(where: {$0.id == id})?.image{
                        if isFullScreen{
                            Image(image)
                                .resizable(resizingMode: .stretch)
                                .scaledToFill()
                        }
                        else{
                            Image(image)
                                .resizable()
                                .scaledToFill()
                        }
                    }
                    else if let color = backgrounds.first(where: {$0.id == id})?.color{
                        Color(hex: color)
                    }
                }
                .ignoresSafeArea()
            }
    }
}

extension View {
    func noteItemBackground(with id: String, isFullScreen: Bool) -> some View {
        modifier(NoteItemBackground(id: id,isFullScreen: isFullScreen))
    }
}

#Preview {
    let config = ModelConfiguration(isStoredInMemoryOnly: true)
    let container = try! ModelContainer(for: NoteBackground.self, configurations: config)

    let background = NoteBackground(id: "2", image: "bird",createdAt: Date.now.addingTimeInterval(2*100))
    container.mainContext.insert(background)
    return VStack{
        VStack{
            Text("s")
                .frame(maxWidth: /*@START_MENU_TOKEN@*/.infinity/*@END_MENU_TOKEN@*/,maxHeight: .infinity)
        }
        .noteItemBackground(with: "2",isFullScreen: false)
    }
    .modelContainer(container)
}

