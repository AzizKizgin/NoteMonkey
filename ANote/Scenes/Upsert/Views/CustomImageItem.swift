//
//  CustomImageItem.swift
//  ANote
//
//  Created by Aziz Kızgın on 15.11.2023.
//

import SwiftUI

struct CustomImageItem: View {
    let image: UIImage?
    var body: some View {
        VStack{
            if let image{
                Image(uiImage: image)
                    .resizable()
                    .frame(width: 125,height: 200)
                    .scaledToFill()
            }
            else {
                ZStack{
                    Color(hex: "default")
                        .frame(width: 125,height: 200)
                    ProgressView()
                }
            }
        }
    }
}

#Preview {
    CustomImageItem(image: nil)
}
