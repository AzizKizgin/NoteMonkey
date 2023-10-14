//
//  CreateThemeView.swift
//  ANote
//
//  Created by Aziz Kızgın on 12.10.2023.
//

import SwiftUI
import PhotosUI

struct CreateThemeView: View {
    @State private var color: Color = .black
    @State private var imageData: Data?
    @State private var selectedImage: PhotosPickerItem?
    @State private var showPreview: Bool = false
    var body: some View {
        VStack{
            if !showPreview{
                ColorPicker(selection: $color){
                    Text("Text Color")
                        .foregroundStyle(color)
                        .font(.title2)
                        .bold()
                        .frame(maxWidth: .infinity,alignment: .leading)
                }
                .padding()
            }
            VStack(alignment:.leading){
                if showPreview{
                    VStack{
                        HStack(spacing:20){
                            Image(systemName: "square.and.arrow.up")
                                .resizable()
                                .scaledToFit()
                            Image(systemName: "paintbrush")
                                .resizable()
                                .scaledToFit()
                            Image(systemName: "trash")
                                .resizable(resizingMode: .tile)
                                .scaledToFit()
                        }
                        .frame(maxWidth: .infinity, maxHeight: 25, alignment:.trailing)
                        Text("Title")
                            .font(.title)
                            .bold()
                            .frame(maxWidth: .infinity,alignment: .leading)
                        Text("Start to write")
                            .frame(maxWidth:.infinity,alignment: .topLeading)
                            .font(.title3)
                            .padding(.top,8)
                            .padding(.leading,5)
                    }
                }
            }
            .animation(.easeIn(duration: 0.2), value: showPreview)
            .frame(maxWidth: .infinity, maxHeight: .infinity,alignment: .topLeading)
            .padding()
            .onChange(of: color) { oldValue, newValue in
                print(newValue)
            }
            .background{
                if showPreview {
                    if let imageData = self.imageData,
                       let uiImage = UIImage(data: imageData){
                        Image(uiImage: uiImage)
                            .resizable()
                            .ignoresSafeArea()
                    }
                    else{
                        Color.white
                            .frame(maxWidth: .infinity,maxHeight: .infinity)
                    }
                }
                else{
                    ImagePicker(imageData: $imageData, selectedImage: $selectedImage)
                }
            }
            .toolbar{
                ToolbarItem(placement: .topBarLeading){
                    Button {
                        showPreview.toggle()
                    } label: {
                        if showPreview {
                            Text("Hide Preview")
                        }
                        else {
                            Text("Show Preview")
                        }
                    }
                    .foregroundStyle(.white)
                    .buttonBorderShape(.roundedRectangle(radius: .infinity))
                    .buttonStyle(.borderedProminent)
                    .tint(.accentColor)
                }
                ToolbarItem(placement: .topBarTrailing){
                    Button {
        
                    } label: {
                        Text("Save")
                    }
                    .foregroundStyle(.white)
                    .buttonBorderShape(.roundedRectangle(radius: .infinity))
                    .buttonStyle(.borderedProminent)
                    .tint(.accentColor)
                }
            }
            .foregroundStyle(color)
        }
    }
}

#Preview {
    NavigationStack{
        CreateThemeView()
    }
}
