//
//  HomeMenu.swift
//  ANote
//
//  Created by Aziz Kızgın on 15.10.2023.
//

import SwiftUI

struct HomeMenu: View {
    @State private var isListView: Bool = true
    @State private var isAllSelected: Bool = false
    let showSelectionMenu: Bool
    let selectedItemCount: Int
    let onCancelSelect: () -> Void
    let onSelectAll: () -> Void
    let onChangeListType: () -> Void
    var body: some View {
        Group{
            if !showSelectionMenu{
                HStack{
                    Spacer()
                    MenuLinkButton(iconName: "gear"){
                        SettingsView()
                    }
                }
                .overlay(alignment: .center){
                    HStack(spacing:20){
                        MenuButton(iconName: isListView ? "square.grid.2x2" : "list.bullet.rectangle.portrait", onPress: {
                            onChangeListType()
                            isListView.toggle()
                        })
                        MenuLinkButton(iconName: "arrow.up.trash") {
                            DeletedNotesView()
                        }
                    }
                }
            }
            else {
                HStack{
                    MenuButton(iconName: "multiply", onPress: {
                        onCancelSelect()
                    })
                    Spacer()
                    Group{
                        if selectedItemCount == 0 {
                            Text("Select Items")
                        }
                        else{
                            Text("^[\(selectedItemCount) item](inflect: true)")
                        }
                    }
                    .foregroundStyle(Color.accentColor)
                    Spacer()
                    MenuButton(iconName: "checkmark.rectangle.stack", onPress: {
                        onSelectAll()
                        isAllSelected.toggle()
                    })
                    .foregroundStyle(isAllSelected ? .green : Color.accentColor)
                }
            }
        }
        .padding(.vertical,5)
        .padding(.horizontal)
        .transition(.move(edge: .top).combined(with: .opacity))
    }
}

#Preview {
    NavigationStack{
        HomeMenu(showSelectionMenu:false,selectedItemCount: 2,onCancelSelect: {},onSelectAll: {},onChangeListType: {})
    }
}
