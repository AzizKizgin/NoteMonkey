//
//  CreateThemeView.swift
//  ANote
//
//  Created by Aziz Kızgın on 12.10.2023.
//

import SwiftUI
import PhotosUI

struct CreateThemeView: View {
    @Environment(\.dismiss) var dismiss
    @Environment(\.modelContext) private var modelContext
    @Bindable var noteBackground: NoteBackground
    @State private var showPreview: Bool = false
    @State private var selectedColor: Color = .black
    @State private var showAlert: Bool = false
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
                        .foregroundStyle(Color(hex: noteBackground.textColor))
                        .font(.title2)
                        .bold()
                        .frame(maxWidth: .infinity,alignment: .leading)
                }
                .padding()
                .onChange(of: selectedColor){ _, newColor in
                    let uiColor = UIColor(newColor)
                    noteBackground.color = rgbToHex(color: uiColor.cgColor.components)
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
                            .foregroundStyle(Color(hex: noteBackground.textColor))
                        Text("Start to write")
                            .frame(maxWidth:.infinity,alignment: .topLeading)
                            .font(.title3)
                            .padding(.top,8)
                            .padding(.leading,5)
                            .foregroundStyle(Color(hex: noteBackground.textColor))
                    }
                }
            }
            .animation(.easeIn(duration: 0.2), value: showPreview)
            .frame(maxWidth: .infinity, maxHeight: .infinity,alignment: .topLeading)
            .padding()
            .background{
                if showPreview {
                    if let imageData = noteBackground.customImage,
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
                    ImagePicker(imageData: $noteBackground.customImage)
                }
            }
            .foregroundStyle(Color(hex: noteBackground.color ?? "default"))
            .alert("Select an image to continue", isPresented: $showAlert) {
                Button("OK") { }
            }
            
        }
    }
}

extension CreateThemeView{
    private func close(){
        if noteBackground.customImage == nil {
            modelContext.delete(noteBackground)
        }
        dismiss()
    }
    
    private func save(){
        if noteBackground.customImage == nil {
            showAlert.toggle()
        }
        else{
            modelContext.insert(noteBackground)
            dismiss()
        }
    }
}

#Preview {
    NavigationStack{
        CreateThemeView(noteBackground: NoteBackground())
    }
}
