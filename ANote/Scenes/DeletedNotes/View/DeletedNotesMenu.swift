//
//  DeletedNotesMenu.swift
//  ANote
//
//  Created by Aziz Kızgın on 18.10.2023.
//

import SwiftUI

struct DeletedNotesMenu: View {
    @State private var isListView: Bool = true
    @State private var isAllSelected: Bool = false
    let showSelectionMenu: Bool
    let selectedItemCount: Int
    let onCancelSelect: () -> Void
    let onSelectAll: () -> Void
    let onChangeListType: () -> Void
    let onDelete: () -> Void
    let onUnDelete: () -> Void
    var body: some View {
        Group{
            if !showSelectionMenu{
                HStack(spacing:20){
                    MenuButton(iconName: isListView ? "square.grid.2x2" : "list.bullet.rectangle.portrait", onPress: {
                        onChangeListType()
                        isListView.toggle()
                    })
                    MenuButton(iconName: "trash", onPress: {})
                }
            }
            else{
                HStack{
                    Spacer()
                    MenuButton(iconName: "multiply", onPress: {
                        onCancelSelect()
                    })
                }
                .overlay(alignment: .center){
                    HStack(spacing:20){
                        MenuButton(iconName: "trash", onPress: onDelete)
                        MenuButton(iconName: "arrowshape.turn.up.left.2", onPress: onUnDelete)
                    }
                }
            }
        }
        .padding(.vertical,5)
        .padding(.horizontal)
        .transition(.move(edge: .top).combined(with: .opacity))
    }
}

#Preview {
    DeletedNotesMenu(showSelectionMenu: true, selectedItemCount: 10, onCancelSelect: {}, onSelectAll: {}, onChangeListType: {},onDelete: {},onUnDelete: {})
}
