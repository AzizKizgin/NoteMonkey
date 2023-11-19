//
//  SettingsView.swift
//  NoteMonkey
//
//  Created by Aziz Kızgın on 18.10.2023.
//

import SwiftUI

struct SettingsView: View {
    @Environment(\.dismiss) var dismiss
    @AppStorage("isDarkMode") var isDarkMode: Bool = true
    var body: some View {
        NavigationStack{
            VStack{
                Form{
                    Section(header: Text("Appearance")) {
                        Toggle("Dark Mode", isOn: $isDarkMode)
                    }
                }
            }
            .toolbar{
                ToolbarItem(placement: .topBarLeading, content: {
                    Button(action: {dismiss()}, label: {
                        Text("Close")
                            .font(.system(size: 20))
                            .foregroundStyle(Color.accentColor)
                    })
                    .buttonStyle(.plain)
                })
            }
            .background(Color.default)
       
        }
        .preferredColorScheme(isDarkMode ? .dark: .light)
    }
}

#Preview {
    SettingsView()
}
