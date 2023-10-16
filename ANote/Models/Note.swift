//
//  Note.swift
//  ANote
//
//  Created by Aziz Kızgın on 8.10.2023.
//

import Foundation
import SwiftData

@Model
final class Note{
    var id: UUID
    var title: String
    var content: String
    var createdAt: Date
    var updatedAt: Date?
    var isPinned: Bool
    var isDeleted: Bool
    @Relationship(deleteRule:.nullify) var background: NoteBackground?
    
    init(
        id: UUID = UUID(),
        title: String,
        content: String,
        createdAt: Date,
        updatedAt: Date? = nil,
        isPinned: Bool = false,
        isDeleted: Bool = false,
        background: NoteBackground? = nil
    ) {
        self.id = id
        self.title = title
        self.content = content
        self.createdAt = createdAt
        self.updatedAt = updatedAt
        self.isPinned = isPinned
        self.isDeleted = isDeleted
        self.background = background
    }
}
