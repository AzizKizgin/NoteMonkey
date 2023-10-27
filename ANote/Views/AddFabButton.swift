//
//  AddFabButton.swift
//  ANote
//
//  Created by Aziz Kızgın on 18.10.2023.
//

import SwiftUI

struct AddFabButton: View {
    var body: some View {
        NavigationLink(destination: UpsertView()){
            VStack{
                Image(systemName: "plus")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 20)
                    .padding(.vertical, 15)
                    .padding(.horizontal,10)
            }
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
