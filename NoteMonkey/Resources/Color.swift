//
//  self = .swift
//  NoteMonkey
//
//  Created by Aziz Kızgın on 11.10.2023.
//

import Foundation
import SwiftUI

extension Color {
    init(hex: String) {
        if hex == "item" {
            self.init(Color.item)
            return
        }
        else if hex == "text" {
            self.init(Color.text)
            return
        }
        else if hex == "note"{
            self.init(Color.note)
            return
        }
        else if hex == "default"{
            self.init(Color.default)
            return
        }
        let hex = hex.trimmingCharacters(in:CharacterSet.alphanumerics.inverted)
        var int: UInt64 = 0
        Scanner(string: hex).scanHexInt64(&int)
        let a, r, g, b: UInt64
        switch hex.count {
        case 3:
            (a, r, g, b) = (255, (int >> 8) * 17, (int >> 4 & 0xF) * 17, (int & 0xF) * 17)
        case 6:
            (a, r, g, b) = (255, int >> 16, int >> 8 & 0xFF, int & 0xFF)
        case 8:
            (a, r, g, b) = (int >> 24, int >> 16 & 0xFF, int >> 8 & 0xFF, int & 0xFF)
        default:
        (a, r, g, b) = (1, 1, 1, 0)
        }

        self.init(
            .displayP3,
            red: Double(r) / 255,
            green: Double(g) / 255,
            blue:  Double(b) / 255,
            opacity: Double(a) / 255
        )
    }
}


func rgbToHex(color: [CGFloat]?) -> String {
    if let color = color{
        let (red,blue,green) = (color[0],color[1],color[2])
        
        return String(format: "#%02X%02X%02X", Int(red * 255), Int(green * 255), Int(blue * 255))
    }
    else {
        return "#000000"
    }
}
