//
//  ImagePicker.swift
//  NoteMonkey
//
//  Created by Aziz Kızgın on 14.10.2023.
//

import SwiftUI
import PhotosUI

struct ImagePicker: View {
    @Binding var image: UIImage?
    @State var selectedImage: PhotosPickerItem?
    @State private var showError: Bool = false
    var body: some View {
        if let image = self.image{
            Image(uiImage: image)
                .resizable()
                .overlay(alignment:.topTrailing){
                    Button {
                        self.image = nil
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
                                
                                guard UIImage(data: data) != nil else {
                                    self.showError.toggle()
                                    return
                                }
                                
                                self.image = UIImage(data: data)
                            }
                        } catch {
                            self.showError.toggle()
                        }
                    }
                }
                .alert("This image cannot be used", isPresented: $showError){
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
    ImagePicker(image: .constant(nil))
}
