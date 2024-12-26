//
//  ExpenseTransactionsView.swift
//  Money
//
//  Created by Iacob Zanoci on 21/12/2024.
//

import SwiftUI

struct ExpenseTransactionsView: View {
    @StateObject var viewModel = MoneyViewModel()
    @State private var isMonthPickerPresented: Bool = false
    
    var body: some View {
        VStack {
            // Your month/year selector and total amount display
            TransactionMonthAmountView(
                selectedMonth: $viewModel.selectedMonth,
                selectedYear: $viewModel.selectedYear,
                totalSpent: $viewModel.spentMoney,
                isMonthPickerPresented: $isMonthPickerPresented
            )
            
            ScrollView {
                VStack(spacing: 16) {
                    ForEach(viewModel.groupedExpenseTransactions, id: \.date) { group in
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
        .onChange(of: viewModel.selectedMonth) { _ in viewModel.updateTotalSpent() }
        .onChange(of: viewModel.selectedYear) { _ in viewModel.updateTotalSpent() }
        .sheet(isPresented: $isMonthPickerPresented) {
            MonthYearPicker(selectedMonth: $viewModel.selectedMonth, selectedYear: $viewModel.selectedYear)
        }
        .navigationTitle("Expenses")
        .navigationBarTitleDisplayMode(.inline)
    }
}

#Preview {
    ExpenseTransactionsView()
        .environmentObject(MoneyViewModel())
}
