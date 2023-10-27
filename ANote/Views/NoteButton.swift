//
//  NoteButton.swift
//  ANote
//
//  Created by Aziz Kızgın on 15.10.2023.
//

import SwiftUI

struct NoteButton: ButtonStyle {
    func makeBody(configuration: Self.Configuration) -> some View {
        configuration.label
            .scaleEffect(configuration.isPressed ? 0.95 : 1.0)
            .animation(.linear(duration: 0.1), value: configuration.isPressed)

    }
}

#Preview {
    Button(action: {
    },
    label: {
        TestNoteView()
    })
    .buttonStyle(NoteButton())
}
