//
//  ImagePickerPlaceHolder.swift
//  ANote
//
//  Created by Aziz Kızgın on 14.10.2023.
//

import SwiftUI

struct ImagePickerPlaceholder: View {
    var body: some View {
        Rectangle()
            .foregroundStyle(.blue.opacity(0.1))
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
