//
//  NoteListItem.swift
//  ANote
//
//  Created by Aziz Kızgın on 8.10.2023.
//

import SwiftUI

struct NoteListItem: View {
    @Bindable var note: Note
    let onLongPress: () -> Void
    let showSelectButton: Bool
    let isSelected: Bool
    let isListView: Bool
    @State private var goDetail: Bool = false
    var body: some View {
        Button(action: {
            
        }, label: {
            VStack(spacing:10){
                Text(!note.title.isEmpty ? note.title : note.content)
                    .lineLimit(1)
                    .frame(maxWidth: .infinity,alignment: .leading)
                    .font(.title3)
                    .bold()
                if !note.content.isEmpty && !note.title.isEmpty{
                    Text(note.content)
                        .frame(maxWidth: .infinity,alignment: .leading)
                        .font(.subheadline)
                        .lineLimit(isListView ? 4 : 10)
                }
                HStack(spacing: 5){
                    Text(Helpers.localizedDate(date: note.createdAt))
                        .font(.footnote)
                    if note.isPinned == 1 && note.deletedAt == nil {
                        VStack(alignment:.center){
                            Image(systemName: "pin")
                                .font(.system(size: 16))
                        }
                            .foregroundStyle(Color.accentColor)
                    }
                } .frame(maxWidth: .infinity,alignment: .leading)
            }
            .padding()
            .frame(maxWidth: .infinity,alignment: .topLeading)
            .frame(height: note.title.isEmpty ? 85 : 110)
            .noteItemBackground(with: note.background?.id ?? "0", isFullScreen: false)
            .foregroundStyle(Color(hex: note.background?.textColor ?? "textColor"))
            .clipShape(RoundedRectangle(cornerSize: CGSize(width: 20, height: 20)))
            .overlay(alignment: .bottomTrailing){
                if showSelectButton{
                    VStack{
                        if isSelected{
                            Image(systemName: "checkmark")
                        }
                    }
                        .frame(width: 30, height: 30)
                        .foregroundStyle(Color.white)
                        .background(Color.accentColor)
                        .clipShape(Circle())
                        .buttonStyle(.borderedProminent)
                        .padding()
                }
            }
        })
        .simultaneousGesture(
            LongPressGesture()
                .onEnded { _ in
                    onLongPress()
                }
        )
        .highPriorityGesture(
            TapGesture()
                .onEnded {
                    if showSelectButton {
                        onLongPress()
                    }
                    else{
                        goDetail.toggle()
                    }
                }
        )
        .buttonStyle(NoteButton())
        .fullScreenCover(isPresented: $goDetail ){
            UpsertView(note: note)
        }
    }
}

#Preview {
    NavigationStack{
        TestNoteView()
           
    }
}
