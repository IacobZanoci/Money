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
    
    // Default initializer to assign an id if not provided
        init(id: UUID = UUID(), name: String, icon: String) {
            self.id = id
            self.name = name
            self.icon = icon
        }
    
    static let expenseCategory: [ExpenseCategory] = [
        ExpenseCategory(id: UUID(), name: "Food", icon: "fork.knife.circle.fill"),
        ExpenseCategory(id: UUID(), name: "Shopping", icon: "bag.circle.fill"),
        ExpenseCategory(id: UUID(), name: "Transport", icon: "car.circle.fill"),
        ExpenseCategory(id: UUID(), name: "Housing", icon: "house.circle.fill"),
        ExpenseCategory(id: UUID(), name: "Utilities", icon: "lightbulb.circle.fill"),
        ExpenseCategory(id: UUID(), name: "Medical Health", icon: "cross.circle.fill"),
        ExpenseCategory(id: UUID(), name: "Insurance", icon: "checkmark.circle.fill"),
        ExpenseCategory(id: UUID(), name: "Kids", icon: "person.2.circle.fill"),
        ExpenseCategory(id: UUID(), name: "Subscriptions", icon: "creditcard.circle.fill"),
        ExpenseCategory(id: UUID(), name: "Personal Care/Dev", icon: "person.crop.circle.fill"),
        ExpenseCategory(id: UUID(), name: "Entertainment", icon: "gamecontroller.circle.fill"),
        ExpenseCategory(id: UUID(), name: "Travel", icon: "airplane.circle.fill"),
        ExpenseCategory(id: UUID(), name: "Gifts", icon: "gift.circle.fill"),
        ExpenseCategory(id: UUID(), name: "Charitable Giving", icon: "heart.circle.fill"),
        ExpenseCategory(id: UUID(), name: "Other", icon: "ellipsis.circle.fill"),
    ]
}
