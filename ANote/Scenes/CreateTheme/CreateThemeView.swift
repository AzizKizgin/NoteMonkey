//
//  CreateThemeView.swift
//  ANote
//
//  Created by Aziz Kızgın on 12.10.2023.
//

import SwiftUI
import PhotosUI

struct CreateThemeView: View {
    @Bindable var noteBackground: NoteBackground
    @Environment(\.dismiss) var dismiss
    @Environment(\.modelContext) private var modelContext
    @State private var showPreview: Bool = false
    @State private var selectedColor: Color = Color(hex: "text")
    @State private var imageData: Data?
    @State private var showAlert: Bool = false
    @State private var errorMessage: String = ""
    
    init(noteBackground: NoteBackground) {
        self.noteBackground = noteBackground
    }

    var body: some View {
        VStack{
            HStack{
                Button(action: close, label: {
                    Text("close")
                })
                .foregroundStyle(Color.accentColor)
                .buttonStyle(.plain)
                Spacer()
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
                .foregroundStyle(Color.accentColor)
                Spacer()
                Button {
                    save()
                } label: {
                    Text("Save")
                    
                }
                .foregroundStyle(Color.accentColor)
            }
            .padding(.horizontal)
            if !showPreview{
                ColorPicker(selection: $selectedColor){
                    Text("Text Color")
                        .foregroundStyle(selectedColor)
                        .font(.title2)
                        .bold()
                        .frame(maxWidth: .infinity,alignment: .leading)
                }
                .padding()
                .onChange(of: selectedColor){ _, newColor in
                    let uiColor = UIColor(newColor)
                    noteBackground.textColor = rgbToHex(color: uiColor.cgColor.components)
                }
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
                            .foregroundStyle(selectedColor)
                        Text("Start to write")
                            .frame(maxWidth:.infinity,alignment: .topLeading)
                            .font(.title3)
                            .padding(.top,8)
                            .padding(.leading,5)
                            .foregroundStyle(selectedColor)
                    }
                }
            }
            .animation(.easeIn(duration: 0.2), value: showPreview)
            .frame(maxWidth: .infinity, maxHeight: .infinity,alignment: .topLeading)
            .padding()
            .background{
                if showPreview {
                    if let imageData = imageData,
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
                    ImagePicker(imageData: $imageData)
                }
            }
            .foregroundStyle(Color(selectedColor))
            .alert(errorMessage, isPresented: $showAlert) {
                Button("OK") { }
            }
            
        }
        .onAppear{
            selectedColor = Color(hex: noteBackground.textColor)
            getImage()
        }
        .background(.default)
    }
}

extension CreateThemeView{
    func save(){
        if let imageData{
            guard let uiImage = UIImage(data: imageData) else {
                self.errorMessage = "This image cannot be used"
                self.showAlert.toggle()
                return
            }
            do {
                try ImageService.saveImage(image: uiImage, imageName: noteBackground.id)
                noteBackground.customImage = noteBackground.id
                modelContext.insert(noteBackground)
                try modelContext.save()
                dismiss()
            } catch ImageError.imageDataConversion {
                self.errorMessage = "An error occurred while processing the image"
                self.showAlert.toggle()
            } catch ImageError.fileWrite{
                self.errorMessage = "An error occurred while saving the image"
                self.showAlert.toggle()
            } catch {
                self.errorMessage = "Something went wrong"
                self.showAlert.toggle()
            }
        }
    }
    
    func getImage(){
       ImageService.loadImage(imageName: noteBackground.id){ image in
            self.imageData = image
        }
    }
    
    func close(){
        if noteBackground.customImage == nil && imageData == nil{
            modelContext.delete(noteBackground)
        }
        dismiss()
    }
}

#Preview {
    NavigationStack{
        CreateThemeView(noteBackground: NoteBackground())
    }
}
