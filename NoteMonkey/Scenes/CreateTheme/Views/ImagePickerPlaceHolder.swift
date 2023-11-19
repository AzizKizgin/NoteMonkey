//
//  ImagePickerPlaceHolder.swift
//  NoteMonkey
//
//  Created by Aziz Kızgın on 14.10.2023.
//

import SwiftUI

struct ImagePickerPlaceholder: View {
    var body: some View {
        Rectangle()
            .foregroundStyle(Color(hex: "default"))
            .overlay{
                Image(systemName: "photo.badge.plus.fill")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 200)
                    .foregroundStyle(.blue)
                    .padding()
            }
    }
}

#Preview {
    ImagePickerPlaceholder()
}
