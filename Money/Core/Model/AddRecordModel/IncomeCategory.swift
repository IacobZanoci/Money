//
//  IncomeCategory.swift
//  Money
//
//  Created by Iacob Zanoci on 20/12/2024.
//

import Foundation

struct IncomeCategory: Identifiable {
    
    let id: UUID
    let name: String
    let icon: String
    
    // Default initializer to assign an id if not provided
        init(id: UUID = UUID(), name: String, icon: String) {
            self.id = id
            self.name = name
            self.icon = icon
        }
    
    static let incomeCategory: [IncomeCategory] = [
        IncomeCategory(id: UUID(), name: "Salary", icon: "briefcase.fill"),
        IncomeCategory(id: UUID(), name: "Freelance", icon: "hammer.fill"),
        IncomeCategory(id: UUID(), name: "Investments", icon: "chart.line.uptrend.xyaxis"),
        IncomeCategory(id: UUID(), name: "Rental Income", icon: "building.2.fill"),
        IncomeCategory(id: UUID(), name: "Bonuses", icon: "star.fill"),
        IncomeCategory(id: UUID(), name: "Gifts", icon: "gift.fill"),
        IncomeCategory(id: UUID(), name: "Business Income", icon: "case.fill"),
        IncomeCategory(id: UUID(), name: "Royalty", icon: "person.crop.circle.dashed"),
        IncomeCategory(id: UUID(), name: "Other", icon: "ellipsis.circle.fill"),
    ]
}
