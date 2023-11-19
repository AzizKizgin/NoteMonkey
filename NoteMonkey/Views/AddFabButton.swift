//
//  AddFabButton.swift
//  NoteMonkey
//
//  Created by Aziz Kızgın on 18.10.2023.
//

import SwiftUI

struct AddFabButton: View {
    @State private var showCreateScreen = false
    var body: some View {
        Button(action: {
            showCreateScreen = true
        }, label: {
            VStack{
                Image(systemName: "plus")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 20)
                    .padding(.vertical, 15)
                    .padding(.horizontal,10)
            }
        })
        .fullScreenCover(isPresented: $showCreateScreen){
            UpsertView(note: Note())
        }
        .buttonStyle(.borderedProminent)
        .buttonBorderShape(.circle)
        .padding(.vertical,30)
        .padding(.horizontal)
    }
}

#Preview {
    AddFabButton()
}
