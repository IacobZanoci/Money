//
//  MoneyViewModel.swift
//  Money
//
//  Created by Iacob Zanoci on 11/12/2024.
//

import SwiftUI
import CoreData

class MoneyViewModel: ObservableObject {
    
    // MARK: Published Proprietes
    @Published var transactions: [Transaction] = [] // Holds all transaction records
    @Published var spentMoney: Float = 0
    @Published var earnedMoney: Float = 0
    @Published var selectedMonth: String
    @Published var selectedYear: String
    
    @Published var expenseCategories: [ExpenseCategory] = ExpenseCategory.expenseCategory
    @Published var selectedExpenseCategory: ExpenseCategory? = ExpenseCategory(name: "Other", icon: "ellipsis.circle.fill")
    
    @Published var incomeCategories: [IncomeCategory] = IncomeCategory.incomeCategory
    @Published var selectedIncomeCategory: IncomeCategory? = IncomeCategory(name: "Other", icon: "ellipsis.circle.fill")
    
    // MARK: Core Data Container
    private let container: NSPersistentContainer
    
    init(container: NSPersistentContainer = PersistenceController.shared.container) {
        self.container = container
        let currentDate = Date()
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MMMM"
        self.selectedMonth = dateFormatter.string(from: currentDate)
        self.selectedYear = String(Calendar.current.component(.year, from: currentDate))
        
        fetchTransactions()
        calculateTotals()
    }
    
    // MARK: Computed Proprietes
    private var selectedMonthAsNumber: Int {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MMMM"
        if let monthDate = dateFormatter.date(from: selectedMonth) {
            return Calendar.current.component(.month, from: monthDate)
        }
        return 1
    }
    
    private var filteredTransactions: [Transaction] {
        transactions.filter { transaction in
            let calendar = Calendar.current
            let transactionDate = transaction.date ?? Date()
            let month = calendar.component(.month, from: transactionDate)
            let year = calendar.component(.year, from: transactionDate)
            return month == selectedMonthAsNumber && year == Int(selectedYear)
        }
    }
    
    // MARK: Grouped Data Computations
    var groupedExpenseTransactions: [(date: String, transactions: [Transaction], totalAmount: Float)] {
        let calendar = Calendar.current
        
        // Group transactions by date
        let grouped = Dictionary(grouping: transactions.filter { $0.type == RecordType.expense.rawValue }) { transaction -> String in
            let date = transaction.date ?? Date()
            if calendar.isDateInToday(date) {
                return "Today"
            } else if calendar.isDateInYesterday(date) {
                return "Yesterday"
            } else {
                let formatter = DateFormatter()
                formatter.dateStyle = .medium
                return formatter.string(from: date)
            }
        }
        
        // Sort groups by date descending and their transactions descending
        return grouped.map { (key, value) in
            let sortedTransactions = value.sorted { ($0.date ?? Date()) > ($1.date ?? Date()) }
            let totalAmount = sortedTransactions.reduce(0) { $0 + $1.amount }
            return (date: key, transactions: sortedTransactions, totalAmount: totalAmount)
        }
        .sorted { $0.transactions.first?.date ?? Date() > $1.transactions.first?.date ?? Date() }
    }
    
    var groupedIncomeRecords: [(categoryName: String, categoryIcon: String, totalAmount: Float)] {
        let grouped = Dictionary(grouping: incomeRecords, by: { $0.categoryName ?? "Unknown" })
        
        return grouped.map { category, transactions in
            let totalAmount = transactions.reduce(0) { $0 + $1.amount }
            let icon = transactions.first?.categoryIcon ?? "briefcase.circle.fill"
            return (categoryName: category, categoryIcon: icon, totalAmount: totalAmount)
        }
    }
    
    var incomeRecords: [Transaction] {
        transactions.filter { $0.type == RecordType.income.rawValue }
    }
    
    // MARK: Public Methods
    func updateFilteredTransactions() {
        if selectedMonth == DateFormatter().monthSymbols[Calendar.current.component(.month, from: Date()) - 1] &&
            selectedYear == String(Calendar.current.component(.year, from: Date())) {
            // If the selected month and year match the current ones, show all transactions
            fetchTransactions()
        } else {
            // Otherwise, filter transactions based on selected month and year
            let filtered = transactions.filter { transaction in
                let calendar = Calendar.current
                let transactionDate = transaction.date ?? Date()
                let month = calendar.component(.month, from: transactionDate)
                let year = calendar.component(.year, from: transactionDate)
                return month == selectedMonthAsNumber && year == Int(selectedYear)
            }
            transactions = filtered
        }
        updateTotalSpent()
    }
    
    func totalAmount(forCategory categoryName: String, type: RecordType) -> Float {
        transactions
            .filter { $0.type == type.rawValue && $0.categoryName == categoryName }
            .reduce(0) { $0 + $1.amount }
    }
    
    func transactions(forCategory categoryName: String) -> [Transaction] {
        transactions.filter { $0.categoryName == categoryName }
    }
    
    func formatDate(_ date: Date) -> String {
        let formatter = DateFormatter()
        
        if Calendar.current.isDateInToday(date) {
            return "Today"
        }
        
        if Calendar.current.isDateInYesterday(date) {
            return "Yesterday"
        }
        
        formatter.dateFormat = "EEEE d"
        return formatter.string(from: date)
    }
    
    func updateTotalSpent() {
        let totalSpent = groupedExpenseTransactions.reduce(0) { $0 + $1.totalAmount }
        spentMoney = totalSpent
    }
    
    func calculateTotals() {
        spentMoney = transactions
            .filter { $0.type == RecordType.expense.rawValue }
            .reduce(0) { $0 + $1.amount }
        
        earnedMoney = transactions
            .filter { $0.type == RecordType.income.rawValue }
            .reduce(0) { $0 + $1.amount }
    }
    
    //MARK: Transaction Management
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
    
    // MARK: Category Management
    func selectedCategory(for type: RecordType) -> String {
        switch type {
        case .expense:
            return selectedExpenseCategory?.name ?? "Other"
        case .income:
            return selectedIncomeCategory?.name ?? "Other"
        }
    }
    
    func resetCategory(for type: RecordType) {
        switch type {
        case .expense:
            selectedExpenseCategory = ExpenseCategory(name: "Other", icon: "ellipsis.circle.fill")
        case .income:
            selectedIncomeCategory = IncomeCategory(name: "Other", icon: "ellipsis.circle.fill")
        }
    }
    
    func selectExpenseCategory(_ expenseCategory: ExpenseCategory) {
        selectedExpenseCategory = expenseCategory
    }
    
    func selectIncomeCategory(_ incomeCategory: IncomeCategory) {
        selectedIncomeCategory = incomeCategory
    }
    
    func categoryListView(for type: RecordType) -> AnyView {
        switch type {
        case .expense:
            return AnyView(ExpenseCategoryListView(viewModel: self))
        case .income:
            return AnyView(IncomeCategoryListView(viewModel: self))
        }
    }
    
    // MARK: Core Data Management
    private func saveToCoreData() {
        do {
            try container.viewContext.save()
        } catch {
            print("Error saving to Core Data: \(error.localizedDescription)")
        }
    }
}

