//
//  Backgrounds.swift
//  ANote
//
//  Created by Aziz Kızgın on 12.10.2023.
//

import Foundation

struct Backgrounds {
    static let backgrounds: [NoteBackground] = [
        NoteBackground(id: "0",color: "note", textColor: "text",createdAt: Date.now.addingTimeInterval(0*100)),
        NoteBackground(id: "1", image: "astronaut",createdAt: Date.now.addingTimeInterval(1*100)),
        NoteBackground(id: "2", image: "bird",createdAt: Date.now.addingTimeInterval(2*100)),
        NoteBackground(id: "3", image: "bengal",createdAt: Date.now.addingTimeInterval(3*100)),
        NoteBackground(id: "4", image: "cat",createdAt: Date.now.addingTimeInterval(4*100)),
        NoteBackground(id: "5", image: "dog",createdAt: Date.now.addingTimeInterval(5*100)),
        NoteBackground(id: "6", image: "halloween",textColor: "#fc0313",createdAt: Date.now.addingTimeInterval(6*100)),
        NoteBackground(id: "7", image: "template",createdAt: Date.now.addingTimeInterval(7*100)),
        NoteBackground(id: "8", image: "flower",createdAt: Date.now.addingTimeInterval(8*100)),
        NoteBackground(id: "9", image: "fish",createdAt: Date.now.addingTimeInterval(9*100)),
        NoteBackground(id: "10", color: "#0579f5",createdAt: Date.now.addingTimeInterval(10*100)),
        NoteBackground(id: "11", color: "#c40e0e",createdAt: Date.now.addingTimeInterval(11*100)),
        NoteBackground(id: "12", color: "#fcba03",createdAt: Date.now.addingTimeInterval(12*100)),
        NoteBackground(id: "13", color: "#ff14ff",createdAt: Date.now.addingTimeInterval(13*100)),
        NoteBackground(id: "14", color: "#800db5",createdAt: Date.now.addingTimeInterval(14*100)),
        NoteBackground(id: "15", color: "#fca503",createdAt: Date.now.addingTimeInterval(15*100)),
        NoteBackground(id: "16", color: "#52390b",createdAt: Date.now.addingTimeInterval(16*100)),
        NoteBackground(id: "17", color: "#3EB489",createdAt: Date.now.addingTimeInterval(17*100))
        ]
}
