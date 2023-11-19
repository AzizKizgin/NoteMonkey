//
//  ContentView.swift
//  NoteMonkey
//
//  Created by Aziz Kızgın on 8.10.2023.
//

import SwiftUI
import SwiftData

struct ContentView: View {
    @Environment(\.modelContext) private var modelContext
    @Query(filter: #Predicate<NoteBackground>{
        background in
        background.customImage != nil
    }) var backgrounds: [NoteBackground]
    @AppStorage("isDefaultsSaved") var isAllReadySaved: Bool = false
    @AppStorage("isDarkMode") var isDarkMode: Bool = false
    @State private var showSplash: Bool = true
    var body: some View {
        NavigationStack{
            if showSplash{
                SplashScreen()
                    .onAppear{
                        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 1){
                            withAnimation{
                                showSplash.toggle()
                            }
                        }
                    }
            }
            else{
                HomeView()
                    .onAppear{
                        DispatchQueue.global(qos: .background).async{
                            if !isAllReadySaved {
                                Backgrounds.backgrounds.forEach{ background in
                                    modelContext.insert(background)
                                }
                                isAllReadySaved.toggle()
                            }
                        }
                    }
            }
        }
        .preferredColorScheme(isDarkMode ? .dark: .light)
    }
}

#Preview {
    MainActor.assumeIsolated{
        let config = ModelConfiguration(isStoredInMemoryOnly: true)
        let container = try! ModelContainer(for: NoteBackground.self, Note.self, configurations: config)

        let background = NoteBackground(id: "2", image: "bird",createdAt: Date.now.addingTimeInterval(2*100))
        container.mainContext.insert(background)
        
        for index in 0...10 {
            let note = Note(
                title: "Note Title",
                content: "Lorem ipsum dolor sit amet",
                createdAt: Date()
            )
            if index % 2 == 0 {
                note.isPinned = 1
            }
            note.background = background
            container.mainContext.insert(note)
        }
        
        return
            NavigationStack{
            ContentView()
        }
        .modelContainer(container)
    }

}
