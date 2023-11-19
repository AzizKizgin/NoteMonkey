//
//  MenuLinkButton.swift
//  NoteMonkey
//
//  Created by Aziz Kızgın on 18.10.2023.
//

import SwiftUI

struct MenuLinkButton<Content: View>: View {
    let iconName: String
    @ViewBuilder let destination: Content
    var body: some View {
        NavigationLink(destination: destination){
            Image(systemName: iconName)
                .font(.system(size: 25))
        }
        .frame(width: 30)
        .buttonStyle(.plain)
        .foregroundStyle(Color.accentColor)
    }
}

#Preview {
    MenuLinkButton(iconName: "arrow.up.trash", destination: {})
}
