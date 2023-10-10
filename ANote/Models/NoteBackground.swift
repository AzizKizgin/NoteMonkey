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
    var id: Int
    let image: String?
    let color: String?
    
    init(id: Int, image: String? = nil, color: String? = nil) {
        self.id = id
        self.image = image
        self.color = color
    }
}

extension NoteBackground{
    static let astronaut = NoteBackground(id: 1, image: "astronaut", color: nil)
    static let autumn = NoteBackground(id: 2, image: "autumn", color: nil)
    static let bengal = NoteBackground(id: 3, image: "bengal", color: nil)
    static let cat = NoteBackground(id: 4, image: "cat", color: nil)
    static let flowers = NoteBackground(id: 5, image: "flowers", color: nil)
    static let lighthouse = NoteBackground(id: 6, image: "lighthouse", color: nil)
    static let template = NoteBackground(id: 7, image: "template", color: nil)
    static let tiger = NoteBackground(id: 8, image: "tiger", color: nil)
    static let blue = NoteBackground(id: 9, image: nil, color: "blue")
    static let red = NoteBackground(id: 10, image: nil, color: "red")
    static let yellow = NoteBackground(id: 11, image: nil, color: "yellow")
    static let pink = NoteBackground(id: 12, image: nil, color: "pink")
    static let purple = NoteBackground(id: 13, image: nil, color: "purple")
    static let orange = NoteBackground(id: 14, image: nil, color: "orange")
    static let brown = NoteBackground(id: 15, image: nil, color: "brown")
    static let mint = NoteBackground(id: 16, image: nil, color: "mint")
}
