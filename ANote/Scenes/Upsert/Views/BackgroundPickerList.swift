//
//  BackgroundPickerList.swift
//  ANote
//
//  Created by Aziz Kızgın on 10.10.2023.
//

import SwiftUI

struct BackgroundPickerList: ViewModifier {
    @Binding var selectedBackground: Int
    
    private func setBackground(id: Int){
        if selectedBackground == id {
            selectedBackground = 0
        }
        else {
            selectedBackground = id
        }
    }
    func body(content: Content) -> some View {
        content
            .overlay(alignment: .bottom){
                ScrollView(.horizontal){
                    LazyHStack{
                        ForEach(Backgrounds.backgrounds, id: \.self) { background in
                            Button(action: {setBackground(id: background.id)}, label: {
                                VStack{
                                    if let image = background.image {
                                        Image(image)
                                            .resizable()
                                            .frame(width: 125,height: 200)
                                            .scaledToFill()
                                    }
                                    else {
                                        ZStack{
                                            Color(hex:background.color ?? "default")
                                                .frame(width: 125,height: 200)
                                            Image(systemName: "text.justifyleft")
                                                .resizable()
                                                .scaledToFit()
                                                .frame(width: 35)
                                                .foregroundStyle(background.id == 0 ? Color(hex:"defaultText") : .white )
                                        }
                                    }
                                }
                                .border(background.id  == 0 ? .black: .white ,width: selectedBackground == background.id ? 5 : 0)
                            })
                            .buttonStyle(PlainButtonStyle())
                        }
                        NavigationLink(destination: Text("sdsad")){
                            ZStack{
                                Color.black
                                    .frame(width: 125,height: 200)
                                    .opacity(0.2)
                                Image(systemName: "plus")
                                    .resizable()
                                    .scaledToFit()
                                    .frame(width: 35)
                                    .foregroundStyle(Color.black.opacity(0.5))
                            }
                        }
                    }
                   
                    .fixedSize()
                    .padding(10)
                    .background(Color.accentColor)
                }
                .frame(height: 170)
                .padding(.bottom,10)
            }
    }
}

extension View {
    func backgroundPickerList(with index: Binding<Int>) -> some View {
        modifier(BackgroundPickerList(selectedBackground: index))
    }
}


#Preview {
    NavigationStack{
        VStack{
            
        }
        .frame(maxWidth: .infinity,maxHeight: .infinity)
        .backgroundPickerList(with: .constant(2))
    }
}
