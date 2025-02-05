//
//  ExpenseCategory.swift
//  Money
//
//  Created by Iacob Zanoci on 13/12/2024.
//

import Foundation

struct ExpenseCategory: Identifiable {
    
    let id: UUID
    let name: String
    let icon: String
    
        init(id: UUID = UUID(), name: String, icon: String) {
            self.id = id
            self.name = name
            self.icon = icon
        }
    
    static let expenseCategory: [ExpenseCategory] = [
        ExpenseCategory(id: UUID(), name: "Groceries", icon: "basket.fill"),
        ExpenseCategory(id: UUID(), name: "Shopping", icon: "bag.fill"),
        ExpenseCategory(id: UUID(), name: "Transport", icon: "bus.fill"),
        ExpenseCategory(id: UUID(), name: "Housing", icon: "house.fill"),
        ExpenseCategory(id: UUID(), name: "Utilities", icon: "lightbulb.fill"),
        ExpenseCategory(id: UUID(), name: "Medical Health", icon: "cross.fill"),
        ExpenseCategory(id: UUID(), name: "Insurance", icon: "checkmark"),
        ExpenseCategory(id: UUID(), name: "Kids", icon: "person.2.fill"),
        ExpenseCategory(id: UUID(), name: "Subscriptions", icon: "arrow.triangle.2.circlepath"),
        ExpenseCategory(id: UUID(), name: "Personal Care/Dev", icon: "person.fill"),
        ExpenseCategory(id: UUID(), name: "Entertainment", icon: "figure.mixed.cardio"),
        ExpenseCategory(id: UUID(), name: "Travel", icon: "airplane"),
        ExpenseCategory(id: UUID(), name: "Gifts", icon: "gift.fill"),
        ExpenseCategory(id: UUID(), name: "Charitable Giving", icon: "heart.fill"),
        ExpenseCategory(id: UUID(), name: "Other", icon: "ellipsis.circle.fill"),
    ]
}
