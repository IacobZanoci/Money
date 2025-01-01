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
            // Month/year selector and total amount display
            TransactionMonthAmountView(
                selectedMonth: $viewModel.selectedMonth,
                selectedYear: $viewModel.selectedYear,
                totalSpent: .constant(viewModel.totalSpentForSelectedMonth),
                isMonthPickerPresented: $isMonthPickerPresented
            )
            .padding(.horizontal)
            .padding(.top, 10)
            
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
        .sheet(isPresented: $isMonthPickerPresented) {
            MonthYearPicker(selectedMonth: $viewModel.selectedMonth, selectedYear: $viewModel.selectedYear, viewModel: viewModel)
                .presentationDetents([.medium, .fraction(0.3)])
                .presentationDragIndicator(.visible)
        }
        .navigationTitle("Expenses")
        .navigationBarTitleDisplayMode(.inline)
    }
}

#Preview {
    ExpenseTransactionsView()
        .environmentObject(MoneyViewModel())
}
