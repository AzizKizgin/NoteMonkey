//
//  NoteBackground.swift
//  ANote
//
//  Created by Aziz Kızgın on 8.10.2023.
//


import Foundation
import SwiftUI
import SwiftData

@Model
class NoteBackground{
    var id: String
    let image: String?
    let color: String?
    let textColor: String
    
    init(id: String, image: String? = nil, color: String? = nil, textColor: String = "#ffffff") {
        self.id = id
        self.image = image
        self.color = color
        self.textColor = textColor
    }
}

