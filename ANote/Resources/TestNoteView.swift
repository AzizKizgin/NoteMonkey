//
//  TestNoteView.swift
//  ANote
//
//  Created by Aziz Kızgın on 18.10.2023.
//

import SwiftUI

struct TestNoteView: View {
    var body: some View {
        NoteListItem(
            note: Note(
                title: "Note Title",
                content: "Lorem ipsum dolor sit amet",
                createdAt: Date(),
                isPinned: 1
            ),
            onLongPress: {},
            showSelectButton: true,
            isSelected: true,
            isListView: false
        )
    }
}

#Preview {
    TestNoteView()
}
