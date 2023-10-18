//
//  MenuButton.swift
//  ANote
//
//  Created by Aziz Kızgın on 17.10.2023.
//

import SwiftUI

struct MenuButton: View {
    let iconName: String
    let onPress: () -> Void
    var body: some View {
        Button(action: onPress, label: {
            Image(systemName: iconName)
                .font(.system(size: 25))
        })
        .frame(width: 30)
        .buttonStyle(.plain)
    }
}

#Preview {
    MenuButton(iconName: "trash", onPress: {})
}
