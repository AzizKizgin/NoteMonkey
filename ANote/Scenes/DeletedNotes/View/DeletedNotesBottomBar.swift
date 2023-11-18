//
//  DeletedNotesBottomBar.swift
//  ANote
//
//  Created by Aziz Kızgın on 18.11.2023.
//

import SwiftUI

struct DeletedNotesBottomBar: View {
    let onUnDelete: () -> Void
    let deleteSelectedNotes: () -> Void
    let selectedItemCount: Int
    @State var showAlert: Bool = false
    var body: some View {
        HStack(spacing:0){
            Button(action: onUnDelete) {
                Image(systemName: "arrowshape.turn.up.left.2")
                    .font(.system(size: 25))
                    .frame(maxWidth: .infinity)
            }
            Button(action: showDeleteAlert) {
                Image(systemName: "trash")
                    .font(.system(size: 25))
                    .frame(maxWidth: .infinity)
            }
        }
        .frame(maxWidth: .infinity)
        .safeAreaPadding(20)
        .background(.default)
        .transition(.move(edge: .bottom).combined(with: .opacity))
        .alert("Delete Note", isPresented: $showAlert) {
            Button("Delete",role:.destructive) {
                deleteSelectedNotes()
            }
            Button("Cancel", role: .cancel) {}
        } message: {Text("^[\(selectedItemCount) note](inflect: true) will delete")}
    }
}

extension DeletedNotesBottomBar{
    private func showDeleteAlert(){
        self.showAlert.toggle()
    }
}

#Preview {
    DeletedNotesBottomBar(onUnDelete: {}, deleteSelectedNotes: {}, selectedItemCount: 11)
}
