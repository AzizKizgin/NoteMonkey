//
//  ImagePicker.swift
//  ANote
//
//  Created by Aziz Kızgın on 14.10.2023.
//

import SwiftUI
import PhotosUI

struct ImagePicker: View {
    @Binding var imageData: Data?
    @Binding var selectedImage: PhotosPickerItem?
    @State private var showError: Bool = false
    var body: some View {
        if let imageData = self.imageData,
           let uiImage = UIImage(data: imageData){
            Image(uiImage: uiImage)
                .resizable()
                .overlay(alignment:.topTrailing){
                    Button {
                        self.imageData = nil
                        self.selectedImage = nil
                    } label: {
                        Image(systemName: "xmark.circle.fill")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 30)
                            .padding()
                    }

                }
        }
        else {
            PhotosPicker(
                selection: self.$selectedImage,
                matching: .images,
                photoLibrary: .shared()) {
                    ImagePickerPlaceholder()
                }
                .onChange(of: self.selectedImage) { oldImage,newImage in
                    Task {
                        do {
                            if let newImage {
                                guard let data = try await loadImageData(from: newImage) else {
                                    self.showError.toggle()
                                    return
                                }
                                
                                guard let image = UIImage(data: data) else {
                                    self.showError.toggle()
                                    return
                                }
                                
                                self.imageData = data
                            }
                        } catch {
                            self.showError.toggle()
                        }
                    }
                }
                .alert("cannot-use-image", isPresented: $showError){
                    Button("ok", role: .cancel) {
                        self.showError.toggle()
                    }
                }
        }
    }
    private func loadImageData(from newImage: PhotosPickerItem?) async throws -> Data? {
        return try await newImage?.loadTransferable(type: Data.self)
    }
}

#Preview{
    ImagePicker(imageData: .constant(nil), selectedImage: .constant(nil))
}
