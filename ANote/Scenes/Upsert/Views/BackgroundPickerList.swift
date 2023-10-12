//
//  BackgroundPickerList.swift
//  ANote
//
//  Created by Aziz Kızgın on 10.10.2023.
//

import SwiftUI

struct BackgroundPickerList: View {
    @Binding var selectedBackground: Int
    
    private func setBackground(id: Int){
        if selectedBackground == id {
            selectedBackground = 0
        }
        else {
            selectedBackground = id
        }
    }
    var body: some View {
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
                                        .foregroundStyle(background.id == 0 ? .black : .white )
                                }
                            }
                        }
                        .border(background.id  == 0 ? .black: .white ,width: selectedBackground == background.id ? 5 : 0)
                    })
                    .buttonStyle(PlainButtonStyle())
                }
            }  
            .fixedSize()
            .padding(10)
        }
        
    }
}

#Preview {
    BackgroundPickerList(selectedBackground: .constant(0))
}
