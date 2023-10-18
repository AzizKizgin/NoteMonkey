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
                    Button(action: {}, label: {
                        Image(systemName: "gear")
                            .font(.system(size: 25))
                    })
                }
                .overlay(alignment: .center){
                    HStack(spacing:20){
                        MenuButton(iconName: isListView ? "square.grid.2x2" : "list.bullet.rectangle.portrait", onPress: {
                            onChangeListType()
                            isListView.toggle()
                            isAllSelected.toggle()
                        })
                        MenuButton(iconName: "arrow.up.trash", onPress: {})
                    }
                }
            }
            else {
                HStack{
                    MenuButton(iconName: "multiply", onPress: {
                        onCancelSelect()
                    })
                    Spacer()
                    if selectedItemCount == 0 {
                        Text("Select Items")
                    }
                    else{
                        Text("^[\(selectedItemCount) item](inflect: true)")
                    }
                    Spacer()
                    MenuButton(iconName: "checkmark.rectangle.stack", onPress: {
                        onSelectAll()
                        isAllSelected.toggle()
                    })
                        .foregroundStyle(isAllSelected ? Color.accentColor: .item)
                }
            }
        }
        .foregroundStyle(.item)
    }
}

#Preview {
    HomeMenu(showSelectionMenu:true,selectedItemCount: 2,onCancelSelect: {},onSelectAll: {},onChangeListType: {})
}
