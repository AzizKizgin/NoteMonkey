//
//  ContentView.swift
//  ANote
//
//  Created by Aziz Kızgın on 8.10.2023.
//

import SwiftUI

struct ContentView: View {
    @Environment(\.modelContext) private var modelContext
    @AppStorage("isDefaultsSaved") var isAllReadySaved: Bool = false
    var body: some View {
        NavigationStack{
            HomeView()
                .onAppear{
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

#Preview {
    ContentView()
}
