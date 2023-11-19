//
//  HomeMenu.swift
//  ANote
//
//  Created by Aziz Kızgın on 15.10.2023.
//

import SwiftUI

struct HomeMenu: View {
    @State var isListView: Bool = true
    var body: some View {
        HStack{
            Spacer()
            Button(action: {}, label: {
                Image(systemName: "gear")
                    .font(.system(size: 25))
            })
        }
        .overlay(alignment: .center){
            HStack(spacing:20){
                Button(action: {
                    isListView.toggle()
                }, label: {
                    if !isListView {
                        Image(systemName: "list.bullet.rectangle.portrait")
                            .font(.system(size: 25))
                    }
                    else{
                        Image(systemName: "square.grid.2x2")
                            .font(.system(size: 25))
                    }
                })
                .frame(width: 30)
                Button(action: {}, label: {
                    Image(systemName: "arrow.up.trash")
                        .font(.system(size: 25))
                })
            }
        }
    }
}

#Preview {
    HomeMenu()
}
