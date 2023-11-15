//
//  ModelSchemaV1.swift
//  ANote
//
//  Created by Aziz Kızgın on 11.11.2023.
//

import Foundation
import SwiftData

enum ModelSchemaV1: VersionedSchema{
    static var versionIdentifier = Schema.Version(
        1,
        0,
        0
    )
    
    static var models: [any PersistentModel.Type]{
        [
            Note.self,
            NoteBackground.self
        ]
    }
    
    @Model
    final class Note{
        var id: UUID
        var title: String
        var content: String
        var createdAt: Date
        var updatedAt: Date?
        var deletedAt: Date?
        var isPinned: Int
        var isDeleted: Bool
        var background: NoteBackground?
        
        
        init(
            id: UUID = UUID(),
            title: String = "",
            content: String = "",
            createdAt: Date = .now,
            updatedAt: Date? = nil,
            isPinned: Int = 0,
            isDeleted: Bool = false,
            deletedAt: Date? = nil
        ) {
            self.id = id
            self.title = title
            self.content = content
            self.createdAt = createdAt
            self.updatedAt = updatedAt
            self.isPinned = isPinned
            self.isDeleted = isDeleted
            self.deletedAt = deletedAt
        }
    }
    
    @Model
    class NoteBackground{
        @Attribute(
            .unique
        )
        var id: String
        var image: String?
        var color: String?
        var customImage: String?
        var textColor: String
        var createdAt: Date?
        @Relationship(
            deleteRule:.noAction,
            inverse: \Note.background
        )
        var note = [Note]()
        init(
            id: String = UUID().uuidString,
            image: String? = nil,
            color: String? = nil,
            textColor: String = "#000000",
            createdAt:Date = .now,
            customImage: String? = nil
        ) {
            self.id = id
            self.image = image
            self.color = color
            self.customImage = customImage
            self.textColor = textColor
            self.createdAt = createdAt
        }
    }

}
