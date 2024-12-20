//
//  MoneyViewModel.swift
//  Money
//
//  Created by Iacob Zanoci on 11/12/2024.
//

import SwiftUI
import CoreData

class MoneyViewModel: ObservableObject {
    @Published var transactions: [Transaction] = [] // Holds all transaction records
    @Published var spentMoney: Float = 0
    @Published var earnedMoney: Float = 0
    
    @Published var expenseCategories: [ExpenseCategory] = ExpenseCategory.expenseCategory
    @Published var selectedExpenseCategory: ExpenseCategory? = ExpenseCategory(name: "Other", icon: "ellipsis.circle.fill")
    
    @Published var incomeCategories: [IncomeCategory] = IncomeCategory.incomeCategory
    @Published var selectedIncomeCategory: IncomeCategory? = IncomeCategory(name: "Other", icon: "ellipsis.circle.fill")
    
    private let container: NSPersistentContainer
    
    init(container: NSPersistentContainer = PersistenceController.shared.container) {
        self.container = container
        fetchTransactions()
        calculateTotals()
    }
    
    /// Fetch all transactions from Core Data
    func fetchTransactions(forCategory categoryName: String? = nil, type: RecordType? = nil) {
        let fetchRequest: NSFetchRequest<Transaction> = Transaction.fetchRequest()
        
        var predicates: [NSPredicate] = []
        
        if let categoryName = categoryName {
            predicates.append(NSPredicate(format: "categoryName == %@", categoryName))
        }
        
        if let type = type {
            predicates.append(NSPredicate(format: "type == %@", type.rawValue))
        }
        
        if !predicates.isEmpty {
            fetchRequest.predicate = NSCompoundPredicate(andPredicateWithSubpredicates: predicates)
        }
        
        do {
            transactions = try container.viewContext.fetch(fetchRequest)
            
            // Debug print to verify saved data
            for transaction in transactions {
                print("""
                ID: \(transaction.objectID)
                Amount: \(transaction.amount)
                Type: \(transaction.type ?? "N/A")
                Date: \(transaction.date ?? Date())
                Category Name: \(transaction.categoryName ?? "N/A")
                Category Icon: \(transaction.categoryIcon ?? "N/A")
                """)
            }
        } catch {
            print("Error fetching transactions: \(error.localizedDescription)")
        }
    }
    
    // Get the selected category name based on record type
    func selectedCategory(for type: RecordType) -> String {
        switch type {
        case .expense:
            return selectedExpenseCategory?.name ?? "Other"
        case .income:
            return selectedIncomeCategory?.name ?? "Other"
        }
    }
    
    // Reset selected category to default
    func resetCategory(for type: RecordType) {
        switch type {
        case .expense:
            selectedExpenseCategory = ExpenseCategory(name: "Other", icon: "ellipsis.circle.fill")
        case .income:
            selectedIncomeCategory = IncomeCategory(name: "Other", icon: "ellipsis.circle.fill")
        }
    }
    
    // Provide the correct category list view
    func categoryListView(for type: RecordType) -> AnyView {
        switch type {
        case .expense:
            return AnyView(ExpenseCategoryListView(viewModel: self))
        case .income:
            return AnyView(IncomeCategoryListView(viewModel: self))
        }
    }
    
    /// Add a new transaction
    func addTransaction(amount: Float, type: RecordType, date: Date, category: ExpenseCategory? = nil, incomeCategory: IncomeCategory? = nil) {
        let transaction = Transaction(context: container.viewContext)
        transaction.amount = abs(amount)
        transaction.type = type.rawValue
        transaction.date = date
        
        switch type {
        case .expense:
            transaction.categoryName = category?.name ?? "Other"
            transaction.categoryIcon = category?.icon ?? "ellipsis.circle.fill"
        case .income:
            transaction.categoryName = incomeCategory?.name ?? "Other"
            transaction.categoryIcon = incomeCategory?.icon ?? "ellipsis.circle.fill"
        }
        
        saveToCoreData()
        fetchTransactions()
        calculateTotals()
    }
    
    /// Calculate total spent and earned amounts
    func calculateTotals() {
        spentMoney = transactions
            .filter { $0.type == RecordType.expense.rawValue }
            .reduce(0) { $0 + $1.amount }
        
        earnedMoney = transactions
            .filter { $0.type == RecordType.income.rawValue }
            .reduce(0) { $0 + $1.amount }
    }
    
    /// Get total amount by category and type
    func totalAmount(forCategory categoryName: String, type: RecordType) -> Float {
        transactions
            .filter { $0.type == type.rawValue && $0.categoryName == categoryName }
            .reduce(0) { $0 + $1.amount }
    }
    
    /// Get transactions for a specific category
    func transactions(forCategory categoryName: String) -> [Transaction] {
        transactions.filter { $0.categoryName == categoryName }
    }
    
    /// Save changes to Core Data
    private func saveToCoreData() {
        do {
            try container.viewContext.save()
        } catch {
            print("Error saving to Core Data: \(error.localizedDescription)")
        }
    }
    
    /// Select an expense category
    func selectExpenseCategory(_ expenseCategory: ExpenseCategory) {
        selectedExpenseCategory = expenseCategory
    }
    
    func selectIncomeCategory(_ incomeCategory: IncomeCategory) {
        selectedIncomeCategory = incomeCategory
    }
}

extension MoneyViewModel {
    var incomeRecords: [Transaction] {
        transactions.filter { $0.type == RecordType.income.rawValue }
    }
}
