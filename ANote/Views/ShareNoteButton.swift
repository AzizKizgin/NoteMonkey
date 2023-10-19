//
//  ShareNoteButton.swift
//  ANote
//
//  Created by Aziz Kızgın on 19.10.2023.
//

import SwiftUI

struct ShareNoteButton: View {
    let title: String?
    let content: String?
    init(title: String?, content: String?) {
        self.title = title
        self.content = content
    }
    var body: some View {
        if title != nil && content != nil {
            ShareLink(
                "",
                item: getShareItem(),
                preview: SharePreview("Export)")
                
            )
            .font(.system(size: 20))
            .frame(width: 30,height: 30)
            .buttonStyle(.plain)
            .foregroundStyle(Color.accentColor)
        }
    }
}

extension ShareNoteButton{
    private func getShareItem() -> String{
        return (title ?? "") + "\n" + (content ?? "")
    }
}

#Preview {
    ShareNoteButton(title: "Test", content: "")
}
