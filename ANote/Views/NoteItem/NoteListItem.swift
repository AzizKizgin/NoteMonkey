//
//  NoteListItem.swift
//  ANote
//
//  Created by Aziz Kızgın on 8.10.2023.
//

import SwiftUI

struct NoteListItem: View {
    let note: Note
    var body: some View {
        VStack(spacing:10){
            Text("Note Title")
                .lineLimit(1)
                .frame(maxWidth: .infinity,alignment: .leading)
                .font(.title3)
                .shadow(radius: 10)
                .bold()
            Text("Lorem ipsum dolor sit amet Lorem ipsum dolor sit amet Lorem ipsum dolor sit amet Lorem ipsum dolor sit amet Lorem ipsum dolor sit amet Lorem ipsum dolor sit amet Lorem ipsum dolor sit amet Lorem ipsum dolor sit amet Lorem ipsum dolor sit amet")
                .frame(maxWidth: .infinity,alignment: .leading)
                .font(.subheadline)
                .lineLimit(4)
                .shadow(color: .black, radius: 10)
            Text("23.00")
                .frame(maxWidth: .infinity,alignment: .leading)
                .font(.footnote)
        }

        .frame(maxWidth: .infinity,minHeight: 50,alignment: .topLeading)
        .padding()
        .noteItemBackground(with: 0)
        .foregroundStyle(.white)
        .clipShape(RoundedRectangle(cornerSize: CGSize(width: 20, height: 20)))

    }
}

#Preview {
    NoteListItem(
        note: Note(
            title: "Note Title",
            content: "Lorem ipsum dolor sit amet",
            createdAt: Date(),
            isPinned: true,
            background: Backgrounds.backgrounds[0]
        )
    )
}
