//
//  ContentView.swift
//  ANote
//
//  Created by Aziz Kızgın on 8.10.2023.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        VStack {
            NoteListItem(note: Note(title: "sadsad", content: "sadasd", createdAt: Date(), background: NoteBackground.astronaut))
        }
        .padding()
    }
}

#Preview {
    ContentView()
}
