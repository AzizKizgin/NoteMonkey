//
//  String.swift
//  NoteMonkey
//
//  Created by Aziz Kızgın on 22.11.2023.
//

import Foundation

extension String{
    mutating func removeSpaces() -> String{
        return self.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines)
    }
}
