//
//  Helpers.swift
//  NoteMonkey
//
//  Created by Aziz Kızgın on 19.10.2023.
//

import Foundation

struct Helpers{
    static func localizedDate(date:Date) -> String {
        let locale = Locale.current.language.languageCode?.identifier ?? "en_us"
        let formatter = DateFormatter()
        formatter.locale = Locale(identifier: locale)
        if Calendar.current.isDateInToday(date){
            formatter.setLocalizedDateFormatFromTemplate("HH:mm")
        }
        else if Calendar.current.isDateInThisYear(date){
            formatter.setLocalizedDateFormatFromTemplate("d MMMM")
        }
        else {
            formatter.setLocalizedDateFormatFromTemplate("dd MMMM yyyy" )
        }
        return formatter.string(from: date)
    }
}
