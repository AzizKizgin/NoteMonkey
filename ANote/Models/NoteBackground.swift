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
    @Attribute(.unique)
    var id: String
    let image: String?
    let color: String?
    let textColor: String
    let createdAt: Date?
    @Relationship(deleteRule:.noAction, inverse: \Note.background)
    var note = [Note]()
    
    
    init(id: String = UUID().uuidString, image: String? = nil, color: String? = nil, textColor: String = "#ffffff",createdAt:Date = .now) {
        self.id = id
        self.image = image
        self.color = color
        self.textColor = textColor
        self.createdAt = createdAt
    }
}

