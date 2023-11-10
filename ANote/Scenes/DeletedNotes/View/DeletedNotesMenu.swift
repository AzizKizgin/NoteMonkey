//
//  DeletedNotesMenu.swift
//  ANote
//
//  Created by Aziz Kızgın on 18.10.2023.
//

import SwiftUI

struct DeletedNotesMenu: View {
    @Environment(\.dismiss) var dismiss
    @State private var isListView: Bool = true
    let showSelectionMenu: Bool
    let selectedItemCount: Int
    let onCancelSelect: () -> Void
    let onSelectAll: () -> Void
    let onChangeListType: () -> Void
    let onDelete: () -> Void
    let onUnDelete: () -> Void
    var body: some View {
        VStack{
            if !showSelectionMenu{
                HStack(spacing:20){
                    MenuButton(iconName: isListView ? "square.grid.2x2" : "list.bullet.rectangle.portrait", onPress: {
                        onChangeListType()
                        isListView.toggle()
                    })
                }
                .frame(maxWidth: .infinity)
                .overlay(alignment: .leading){
                    Button(action: {dismiss()}, label: {
                        Text("Close")
                            .font(.system(size: 20))
                            .foregroundStyle(Color.accentColor)
                    })
                    .buttonStyle(.plain)
                }
            }
            else{
                HStack{
                    MenuButton(iconName: "multiply", onPress: onCancelSelect)
                    Spacer()
                    MenuButton(iconName: "checkmark.rectangle.stack", onPress: onSelectAll)
                }
                .overlay(alignment: .center){
                    HStack(spacing:20){
                        MenuButton(iconName: "trash", onPress: onDelete)
                        MenuButton(iconName: "arrowshape.turn.up.left.2", onPress: onUnDelete)
                    }
                }
            }
        }
        .transition(.move(edge: .top).combined(with: .opacity))
        .background(Color.default)
        .animation(.easeInOut(duration: 0.5),value: isListView)
        .padding(.vertical,5)
        .padding(.horizontal)
        
 
    }
}

#Preview {
    DeletedNotesMenu(showSelectionMenu: true, selectedItemCount: 10, onCancelSelect: {}, onSelectAll: {}, onChangeListType: {},onDelete: {},onUnDelete: {})
}
