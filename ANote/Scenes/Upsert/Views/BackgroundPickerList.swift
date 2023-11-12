//
//  BackgroundPickerList.swift
//  ANote
//
//  Created by Aziz Kızgın on 10.10.2023.
//

import SwiftUI
import SwiftData

struct BackgroundPickerList: ViewModifier {
    @Environment(\.modelContext) private var modelContext
    @Query(filter: #Predicate<NoteBackground>{
        background in
        background.image != nil || background.color != nil || background.customImage != nil
    } , sort: \NoteBackground.createdAt) var backgrounds: [NoteBackground]
    @Binding var selectedBackground: NoteBackground
    @State private var showCreateTheme: Bool = false
    let isVisible: Bool

    func body(content: Content) -> some View {
        content
            .overlay(alignment: .bottom){
                if isVisible {
                    ScrollView(.horizontal){
                        LazyHStack{
                            ForEach(backgrounds, id: \.id) { background in
                                Button(action: {setBackground(id: background.id)}, label: {
                                    VStack{
                                        if let image = background.image {
                                            Image(image)
                                                .resizable()
                                                .frame(width: 125,height: 200)
                                                .scaledToFill()
                                        }
                                        else if let customImage = background.customImage, let uiImage = UIImage(data: customImage){
                                            Image(uiImage: uiImage)
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
                                                    .foregroundStyle(background.id == "0" ? Color(hex:"item") : .white )
                                            }
                                        }
                                    }
                                    .border(background.id  == "0" ? .black: .white ,width: selectedBackground.id == background.id ? 5 : 0)
                                })
                                .buttonStyle(PlainButtonStyle())
                            }
                            Button {
                                showCreateTheme.toggle()
                            } label: {
                                ZStack{
                                    Color.black
                                        .frame(width: 125,height: 200)
                                        .opacity(0.2)
                                    Image(systemName: "plus")
                                        .resizable()
                                        .scaledToFit()
                                        .frame(width: 35)
                                        .foregroundStyle(Color.black.opacity(0.5))
                                }
                            }

                        }
                        .fixedSize()
                        .padding(10)
                        .background(Color.accentColor)
                    }
                    .frame(height: 170)
                    .padding(.bottom,10)
                    .fullScreenCover(isPresented: $showCreateTheme){
                        CreateThemeView(noteBackground: NoteBackground())
                    }
                }
            }
    }
}

extension BackgroundPickerList{
    private func setBackground(id: String){
        withAnimation{
            if self.selectedBackground.id == id {
                self.selectedBackground = backgrounds[0]
            }
            else {
                self.selectedBackground = backgrounds.first(where: {$0.id == id}) ?? backgrounds[0]
            }
        }
    }
}

extension View {
    func backgroundPickerList(with background: Binding<NoteBackground>, isVisible: Bool) -> some View {
        modifier(BackgroundPickerList(selectedBackground: background,isVisible: isVisible))
    }
}


#Preview {
    NavigationStack{
        VStack{
            
        }
        .frame(maxWidth: .infinity,maxHeight: .infinity)
        .backgroundPickerList(with: .constant(NoteBackground(id: "0", textColor: "text")), isVisible: true)
    }
}
