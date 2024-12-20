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
        IncomeCategory(id: UUID(), name: "Salary", icon: "briefcase.circle.fill"),
        IncomeCategory(id: UUID(), name: "Freelance", icon: "hammer.circle.fill"),
        IncomeCategory(id: UUID(), name: "Investments", icon: "chart.line.uptrend.xyaxis.circle.fill"),
        IncomeCategory(id: UUID(), name: "Rental Income", icon: "house.lodge.circle.fill"),
        IncomeCategory(id: UUID(), name: "Bonuses", icon: "star.circle.fill"),
        IncomeCategory(id: UUID(), name: "Gifts", icon: "gift.circle.fill"),
        IncomeCategory(id: UUID(), name: "Business Income", icon: "storefront.circle.fill"),
        IncomeCategory(id: UUID(), name: "Royalty", icon: "person.crop.circle.dashed.circle.fill"),
        IncomeCategory(id: UUID(), name: "Other", icon: "ellipsis.circle.fill"),
    ]
}
