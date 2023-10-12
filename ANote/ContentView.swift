//
//  ContentView.swift
//  ANote
//
//  Created by Aziz Kızgın on 8.10.2023.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        NavigationStack{
            VStack{
                NavigationLink(destination: UpsertView(), label: {Text("sdsd")})
            }
        }
    }
}

#Preview {
    ContentView()
}
