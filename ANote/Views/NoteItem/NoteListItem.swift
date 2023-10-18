//
//  NoteListItem.swift
//  ANote
//
//  Created by Aziz Kızgın on 8.10.2023.
//

import SwiftUI

struct NoteListItem: View {
    let note: Note
    let onLongPress: () -> Void
    let showSelectButton: Bool
    let isSelected: Bool
    let isListView: Bool
    @State private var goDetail: Bool = false
    var body: some View {
        Button(action: {
            
        }, label: {
            VStack(spacing:10){
                Text("Note Title")
                    .lineLimit(1)
                    .frame(maxWidth: .infinity,alignment: .leading)
                    .font(.title3)
                    .shadow(radius: 10)
                    .bold()
                Text("Lorem ipsum dolor sit amet Lorem ipsum dolor sit amet Lorem ipsum dolor sit amet Lorem ipsum dolor sit amet Lorem ipsum dolor sit amet Lorem ipsum dolor sit amet Lorem ipsum dolor sit amet Lorem ipsum dolor sit amet Lorem ipsum dolor sit amet")
                    .frame(maxWidth: .infinity,alignment: .leading)
                    .font(.subheadline)
                    .lineLimit(isListView ? 4 : 10)
                    .shadow(color: .black, radius: 10)
                Text("23.00")
                    .frame(maxWidth: .infinity,alignment: .leading)
                    .font(.footnote)
            }
            .padding()
            .frame(maxWidth: .infinity,minHeight: 50,alignment: .topLeading)
            .noteItemBackground(with: "1",isFullScreen: false)
            .foregroundStyle(.white)
            .clipShape(RoundedRectangle(cornerSize: CGSize(width: 20, height: 20)))
            .overlay(alignment: .bottomTrailing){
                if showSelectButton{
                    VStack{
                        if isSelected{
                            Image(systemName: "checkmark")
                        }
                    }
                        .frame(width: 30, height: 30)
                        .foregroundColor(Color.white)
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
        .navigationDestination(isPresented: $goDetail, destination: {
            UpsertView()
        })
    }
}

#Preview {
    NavigationStack{
        TestNoteView()
    }
}
