//
//  CustomImageItem.swift
//  ANote
//
//  Created by Aziz Kızgın on 15.11.2023.
//

import SwiftUI

struct CustomImageItem: View {
    let imageName: String
    @State private var uiImage: UIImage?
    var body: some View {
        VStack{
            if let uiImage{
                Image(uiImage: uiImage)
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
        .onAppear{
            if self.uiImage == nil {
                if let cachedImage = ImageCache.shared.get(forKey: imageName){
                    self.uiImage = cachedImage
                }
                else{
                    ImageService.loadImage(imageName: imageName){ imageData in
                        if let imageData, let uiImage = UIImage(data: imageData) {
                            self.uiImage = uiImage
                            ImageCache.shared.set(uiImage, forKey: imageName)
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
