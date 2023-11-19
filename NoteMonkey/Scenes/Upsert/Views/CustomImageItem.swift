//
//  CustomImageItem.swift
//  ANote
//
//  Created by Aziz Kızgın on 15.11.2023.
//

import SwiftUI

struct CustomImageItem: View {
    let imageName: String
    @State private var image: UIImage?
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
                    Color(hex: "note")
                        .frame(width: 125,height: 200)
                    ProgressView()
                }
            }
        }
        .onAppear{
            Task{
                if self.image == nil {
                    let customImage = await ImageService.loadImage(imageName: imageName)
                    withAnimation{
                        if let customImage{
                            self.image = customImage
                        }
                    }
                }
            }
        }
    }
}

#Preview {
    CustomImageItem(imageName: "")
}
