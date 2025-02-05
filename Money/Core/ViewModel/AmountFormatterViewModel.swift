//
//  SpendingViewModel.swift
//  Money
//
//  Created by Iacob Zanoci on 27/01/2025.
//

import Foundation

class AmountFormatterViewModel: ObservableObject {
    @Published var spentToday: Double = 0.0
    
    func formattedAmount(_ amount: Float) -> String {
        let formatter = NumberFormatter()
        formatter.groupingSeparator = " "
        formatter.numberStyle = .decimal
        
        switch amount {
        case 1_000_000_000...:
            return String(format: "%.0fB", amount / 1_000_000_000)
        case 1_000_000...:
            return String(format: "%.0fM", amount / 1_000_000)
        case 100_000...:
            formatter.maximumFractionDigits = 0
            return formatter.string(from: NSNumber(value: amount)) ?? "\(amount)"
        case 10_000...:
            formatter.maximumFractionDigits = 2
            return formatter.string(from: NSNumber(value: amount)) ?? "\(amount)"
        case 1_000...:
            formatter.maximumFractionDigits = 2
            return formatter.string(from: NSNumber(value: amount)) ?? "\(amount)"
        default:
            return String(format: "%.2f", amount)
        }
    }
}
