//
//  NoteMonkeyApp.swift
//  NoteMonkey
//
//  Created by Aziz Kızgın on 8.10.2023.
//

import SwiftUI
import SwiftData

@main
struct NoteMonkeyApp: App {
    let modelContainer : ModelContainer
    
    init() {
        do{
            modelContainer = try ModelContainer(for: Note.self, NoteBackground.self, migrationPlan: nil)
        }
        catch{
            fatalError("failed when initialize model container")
        }
    }
    var body: some Scene {
        WindowGroup {
            ContentView()
                .modelContainer(modelContainer)
        }
    }
}
