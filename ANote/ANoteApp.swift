//
//  ANoteApp.swift
//  ANote
//
//  Created by Aziz Kızgın on 8.10.2023.
//

import SwiftUI
import SwiftData

@main
struct ANoteApp: App {
    let modelContainer : ModelContainer = {
        let schema = Schema([Note.self,NoteBackground.self])
        let configurations = ModelConfiguration(schema:schema)
        let container = try! ModelContainer(for: schema, configurations: configurations)
        return container
    }()
    var body: some Scene {
        WindowGroup {
            ContentView()
                .modelContainer(modelContainer)
        }
    }
}
