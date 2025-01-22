//
//  RecordAmountFormatter.swift
//  Money
//
//  Created by Iacob Zanoci on 22/01/2025.
//

import Foundation

struct RecordAmountFormatter {
    static func formatRecordAmountCount(_ newValue: String) -> String {
        let formatted = newValue.filter { $0.isNumber || $0 == "." }
        if formatted.filter({ $0 == "." }).count > 1 {
            return String(formatted.dropLast())
        } else {
            return formatted
        }
    }
}
