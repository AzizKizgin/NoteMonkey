//
//  NoteItemBackground.swift
//  ANote
//
//  Created by Aziz Kızgın on 8.10.2023.
//

import SwiftUI
import SwiftData

struct NoteItemBackground: ViewModifier {
    @Query var backgrounds: [NoteBackground]
    let id: String
    let isFullScreen: Bool
    @State var customImage: Data?
    private var selectedBackground: NoteBackground? {
        backgrounds.first { $0.id == id }
    }
    func body(content: Content) -> some View {
        content
            .background{
                VStack{
                    if id == "0" {
                        DefaultBackground()
                    }
                    else if let customImage = customImage,
                                let uiImage = UIImage(data: customImage,scale: 1.2){
                            if isFullScreen{
                                Image(uiImage: uiImage)
                                    .resizable(resizingMode: .stretch)
                                    .scaledToFill()
                            }
                            else{
                                Image(uiImage: uiImage)
                                    .resizable()
                                    .scaledToFit()
                                    .frame(width: 400, height: 1000)
                                    .offset(y: 20)
                                    .frame(width: 400, height: 110)
                                    .clipped()
                                    .contentShape(Rectangle())
                            }
                     
                    }
                    else if let image = selectedBackground?.image{
                        if isFullScreen{
                            Image(image)
                                .resizable(resizingMode: .stretch)
                                .scaledToFill()
                        }
                        else{
                            Image(image)
                                .resizable()
                                .scaledToFit()
                                .frame(width: 400, height: 1000)
                                .offset(y: 20)
                                .frame(width: 400, height: 110)
                                .clipped()
                                .contentShape(Rectangle())
                        }
                    }
                    else if let color = selectedBackground?.color{
                        Color(hex: color)
                    }
                    else{
                        DefaultBackground()
                    }
                }
                .ignoresSafeArea()
            }
            .onChange(of: id){
                ImageService.loadImage(imageName: id) { imageData in
                    self.customImage = imageData
                  }
            }
            .onAppear{
                ImageService.loadImage(imageName: selectedBackground?.customImage ?? "") { imageData in
                    self.customImage = imageData
                  }
            }
    }
}

extension NoteItemBackground{
    private func DefaultBackground() -> some View {
        isFullScreen ? Color.default: Color.note
    }
}


extension View {
    func noteItemBackground(with id: String, isFullScreen: Bool) -> some View {
        modifier(NoteItemBackground(id: id,isFullScreen: isFullScreen))
    }
}

#Preview {
    let config = ModelConfiguration(isStoredInMemoryOnly: true)
    let container = try! ModelContainer(for: NoteBackground.self, configurations: config)

    let background = NoteBackground(id: "2", image: "bird",createdAt: Date.now.addingTimeInterval(2*100))
    container.mainContext.insert(background)
    return VStack{
        VStack{
            Text("s")
                .frame(maxWidth: /*@START_MENU_TOKEN@*/.infinity/*@END_MENU_TOKEN@*/,maxHeight: .infinity)
        }
        .noteItemBackground(with: "2",isFullScreen: false)
    }
    .modelContainer(container)
}

