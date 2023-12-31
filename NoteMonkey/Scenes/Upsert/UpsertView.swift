//
//  UpsertView.swift
//  NoteMonkey
//
//  Created by Aziz Kızgın on 10.10.2023.
//

import SwiftUI
import SwiftData

var descriptor: FetchDescriptor<NoteBackground> {
    var descriptor = FetchDescriptor<NoteBackground>(sortBy: [SortDescriptor(\.createdAt)])
    descriptor.fetchLimit = 1
    return descriptor
}



struct UpsertView: View {
    enum Field{
        case content, title
    }
    @Environment(\.modelContext) private var modelContext
    @Environment(\.dismiss) var dismiss
    @Query(descriptor) var backgrounds: [NoteBackground]
    @Bindable var note: Note
    @State private var showBackgroundList: Bool = false
    @State private var selectedBackground: NoteBackground = NoteBackground(id: "0", textColor: "text")
    @FocusState private var isFocused: Field?
    
    var body: some View {
        NavigationView{
            VStack{
                TextField("", text: $note.title, prompt: isFocused != .title ? Text("Title")
                    .foregroundStyle(Color(hex:selectedBackground.textColor).opacity(0.5))
                    .bold(): nil)
                .focused($isFocused, equals: .title)
                .foregroundStyle(Color(hex: selectedBackground.textColor))
                .font(.title)
                .bold()
                TextEditor(text: $note.content)
                    .focused($isFocused,equals: .content)
                    .scrollContentBackground(.hidden)
                    .foregroundStyle(Color(hex: selectedBackground.textColor))
                    .background(.clear)
                    .font(.title3)
                    .autocorrectionDisabled()
                    .background{
                        if(isFocused != .content && note.content.isEmpty && note.deletedAt == nil){
                            Text("Start to write")
                                .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .topLeading)
                                .font(.title3)
                                .padding(.top,8)
                                .padding(.leading,5)
                                .foregroundStyle(Color(hex: selectedBackground.textColor).opacity(0.5))
                        }
                    }
            }
            .disabled(note.deletedAt != nil)
            .padding()
            .onTapGesture {
                showBackgroundList = false
            }
            
            .backgroundPickerList(with: $selectedBackground, isVisible: showBackgroundList)
            .noteItemBackground(with: selectedBackground.id ,isFullScreen: true)
            .animation(.easeIn(duration: 0.2), value: showBackgroundList)
            .frame(maxHeight: .infinity,alignment: .top)
            .foregroundStyle(.white)
            .ignoresSafeArea(.keyboard)
            .toolbar{
                ToolbarItem(placement: .topBarLeading, content: {
                    Button(action: close, label: {
                        Text("Close")
                            .font(.system(size: 20))
                            .foregroundStyle(Color.accentColor)
                    })
                    .buttonStyle(.plain)
                })
                ToolbarItem(placement:.topBarTrailing){
                    HStack(spacing:20){
                        if isFocused != nil{
                            Button(action: {isFocused = nil}, label: {
                                Text("Done")
                                    .font(.system(size: 20))
                                    .foregroundStyle(Color.accentColor)
                            })
                            .buttonStyle(.plain)
                        }
                        else{
                            ShareNoteButton(title: note.title, content: note.content)
                                .disabled(note.content.isEmpty && note.title.isEmpty)
                            MenuButton(iconName: "paintbrush", onPress: toggleBackgroundList, size: 20)
                            MenuButton(iconName: "trash", onPress: onDelete, size: 20)
                        }
                    }
                    .padding(.horizontal)
                    .disabled(note.deletedAt != nil)
                }
            }
            .onAppear{
                self.selectedBackground = note.background ?? backgrounds[0]
            }
            .onChange(of: selectedBackground){ _ , newBackground in
                note.background = newBackground
            }
        }
    }
}

extension UpsertView{
    private func toggleBackgroundList(){
        showBackgroundList.toggle()
    }
    
    private func onDelete(){
        if !note.title.isEmpty || !note.content.isEmpty {
            note.deletedAt = .now
            note.isDeleted.toggle()
        }
        else {
            modelContext.delete(note)
        }
        dismiss()
    }
    
    private func close(){
        if note.title.removeSpaces().isEmpty && note.content.removeSpaces().isEmpty{
            modelContext.delete(note)
        }
        dismiss()
    }
}

#Preview {
    MainActor.assumeIsolated{
        let config = ModelConfiguration(isStoredInMemoryOnly: true)
        let container = try! ModelContainer(for: NoteBackground.self, configurations: config)
        
        let background = NoteBackground(id: "0", image: "bird", textColor: "#000",createdAt: Date.now.addingTimeInterval(2*100))
        container.mainContext.insert(background)
        
        let background2 = NoteBackground(id: "1", color: "#223233", textColor: "#000", createdAt: Date.now.addingTimeInterval(2*100))
        container.mainContext.insert(background2)
        
        return UpsertView(note: Note(isDeleted: true,deletedAt: .now))
            .modelContainer(container)
    }
    
}
