//
//  ButtonBackgroundHelper.swift
//  Money
//
//  Created by Iacob Zanoci on 22/01/2025.
//

import SwiftUI

struct ButtonBackgroundHelper {
    static func getBackgroundColor(for expenseCount: String?, recordType: RecordType) -> Color {
        guard let amount = Float(expenseCount ?? ""), amount > 0 else {
            return Color.gray.opacity(0.5)
        }
        
        return recordType == .expense ? Color.theme.red : Color.theme.green
    }
}
