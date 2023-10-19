//
//  Calendar.swift
//  ANote
//
//  Created by Aziz Kızgın on 19.10.2023.
//

import Foundation
extension Calendar {
    private var currentDate: Date { return Date() }
    
    func isDateInThisYear(_ date: Date) -> Bool {
        return isDate(date, equalTo: currentDate, toGranularity: .year)
    }
    
}
