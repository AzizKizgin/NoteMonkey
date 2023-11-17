//
//  ContentView.swift
//  ANote
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
    var body: some View {
        NavigationStack{
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
}

#Preview {
    ContentView()
}
