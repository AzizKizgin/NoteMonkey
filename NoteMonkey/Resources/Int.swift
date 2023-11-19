//
//  Int.swift
//  NoteMonkey
//
//  Created by Aziz Kızgın on 4.11.2023.
//

import Foundation

extension Int{
    mutating func toggle() {
        if self == 1 {
            self = 0
            return
        }
        else if self == 0 {
            self = 1
            return
        }
        return
    }
}
