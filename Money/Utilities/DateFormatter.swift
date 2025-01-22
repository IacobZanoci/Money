//
//  DateFormatter.swift
//  Money
//
//  Created by Iacob Zanoci on 22/01/2025.
//

import Foundation

struct DateFormatterUtil {
    static func formatDate(_ date: Date) -> String {
        let calendar = Calendar.current
        let today = calendar.isDateInToday(date)
        
        let timeFormatter = DateFormatter()
        timeFormatter.dateStyle = .none
        timeFormatter.timeStyle = .short
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .medium
        dateFormatter.timeStyle = .none
        
        if today {
            return "Today at \(timeFormatter.string(from: date))"
        } else {
            return "\(dateFormatter.string(from: date)) at \(timeFormatter.string(from: date))"
        }
    }
}
