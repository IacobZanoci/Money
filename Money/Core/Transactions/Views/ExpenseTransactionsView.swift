//
//  ExpenseTransactionsView.swift
//  Money
//
//  Created by Iacob Zanoci on 21/12/2024.
//

import SwiftUI

struct ExpenseTransactionsView: View {
    @StateObject var viewModel = MoneyViewModel()
    @State private var selectedMonth: String
    @State private var selectedYear: String
    @State private var isMonthPickerPresented: Bool = false
    
    // Initialize selectedMonth and selectedYear with current date
    init() {
        let currentDate = Date()
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MMMM"
        self._selectedMonth = State(initialValue: dateFormatter.string(from: currentDate))
        self._selectedYear = State(initialValue: String(Calendar.current.component(.year, from: currentDate)))
    }
    
    // Convert selectedMonth to a number (e.g., "January" -> 1)
    private var selectedMonthAsNumber: Int {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MMMM"
        if let monthDate = dateFormatter.date(from: selectedMonth) {
            return Calendar.current.component(.month, from: monthDate)
        }
        return 1
    }
    
    // Filtered transactions based on selected month and year
    private var filteredTransactions: [Transaction] {
        viewModel.transactions.filter { transaction in
            let calendar = Calendar.current
            let transactionDate = transaction.date ?? Date()
            let month = calendar.component(.month, from: transactionDate)
            let year = calendar.component(.year, from: transactionDate)
            return month == selectedMonthAsNumber && year == Int(selectedYear)
        }
    }
    
    private var groupedExpenseTransactions: [(date: String, totalAmount: Double, transactions: [Transaction])] {
        let calendar = Calendar.current
        let grouped = Dictionary(grouping: filteredTransactions) { transaction -> String in
            let date = transaction.date ?? Date()
            return formatDate(date)
        }
        
        return grouped.map { (key, value) in
            let totalAmount = value.reduce(0.0) { $0 + Double($1.amount) }
            return (date: key, totalAmount: totalAmount, transactions: value)
        }.sorted { $0.date > $1.date }
    }

    // Function to format date as "Today", "Yesterday", or "Day of Week Day"
    private func formatDate(_ date: Date) -> String {
        let formatter = DateFormatter()
        
        // Check if the date is today
        if Calendar.current.isDateInToday(date) {
            return "Today"
        }
        
        // Check if the date is yesterday
        if Calendar.current.isDateInYesterday(date) {
            return "Yesterday"
        }
        
        // For past dates, display "DayOfWeek Day"
        formatter.dateFormat = "EEEE d" // "Saturday 21"
        return formatter.string(from: date)
    }
    
    var body: some View {
        VStack {
            // Your month/year selector and total amount display
            TransactionMonthAmountView(
                selectedMonth: $selectedMonth,
                selectedYear: $selectedYear,
                totalSpent: $viewModel.spentMoney,
                isMonthPickerPresented: $isMonthPickerPresented
            )
            
            ScrollView {
                VStack(spacing: 16) {
                    ForEach(groupedExpenseTransactions, id: \.date) { group in
                        ExpenseContainerListAndDate(
                            date: group.date,
                            totalAmount: "- $\(String(format: "%.2f", group.totalAmount))",
                            transactions: group.transactions
                        )
                    }
                }
                .padding()
            }
        }
        .onChange(of: selectedMonth) { _ in updateTotalSpent() }
        .onChange(of: selectedYear) { _ in updateTotalSpent() }
        .sheet(isPresented: $isMonthPickerPresented) {
            MonthYearPicker(selectedMonth: $selectedMonth, selectedYear: $selectedYear)
        }
        .navigationTitle("Expenses")
        .navigationBarTitleDisplayMode(.inline)
    }
    
    // Update total spent based on selected month and year
    private func updateTotalSpent() {
        let totalSpent = groupedExpenseTransactions.reduce(0) { $0 + $1.totalAmount }
        viewModel.spentMoney = Float(totalSpent)
    }
}

#Preview {
    ExpenseTransactionsView()
        .environmentObject(MoneyViewModel())
}
