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
    let size: CGFloat
    let color: Color
    
    init(iconName: String, onPress: @escaping () -> Void, size: CGFloat = 25, color :Color = .accentColor) {
        self.iconName = iconName
        self.onPress = onPress
        self.size = size
        self.color = color
    }
    var body: some View {
        Button(action: onPress, label: {
            Image(systemName: iconName)
                .font(.system(size: size))
        })
        .frame(width: 30,height: 30)
        .buttonStyle(.plain)
        .foregroundStyle(color)
    }
}

#Preview {
    MenuButton(iconName: "trash", onPress: {})
}
