//
//  CategoryFilter.swift
//  Money
//
//  Created by Iacob Zanoci on 22/01/2025.
//

import Foundation

class CategoryFilter {
    
    static func filterExpenseCategories(_ categories: [ExpenseCategory], searchText: String) -> [ExpenseCategory] {
        if searchText.isEmpty {
            return categories
        } else {
            return categories.filter {
                $0.name.localizedCaseInsensitiveContains(searchText)
            }
        }
    }
    
    static func filterIncomeCategories(_ categories: [IncomeCategory], searchText: String) -> [IncomeCategory] {
        if searchText.isEmpty {
            return categories
        } else {
            return categories.filter {
                $0.name.localizedCaseInsensitiveContains(searchText)
            }
        }
    }
}
