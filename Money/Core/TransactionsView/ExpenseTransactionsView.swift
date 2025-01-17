//
//  ExpenseTransactionsView.swift
//  Money
//
//  Created by Iacob Zanoci on 21/12/2024.
//

import SwiftUI

struct ExpenseTransactionsView: View {
    @EnvironmentObject var viewModel: MoneyViewModel
    @EnvironmentObject var currencySettings: CurrencySettings
    
    @StateObject var transactionViewModel = TransactionViewModel()
    
    @State private var isMonthPickerPresented: Bool = false
    @State private var isEditing: Bool = false
    @State private var transactionToDelete: Transaction? = nil
    
    var body: some View {
        VStack {
            TransactionMonthAmountView(
                selectedMonth: $viewModel.selectedMonth,
                selectedYear: $viewModel.selectedYear,
                totalAmount: .constant(viewModel.totalSpentForSelectedMonth),
                isMonthPickerPresented: $isMonthPickerPresented,
                transactionType: .expense
            )
            .padding(.horizontal)
            .padding(.top, 10)
            
            ScrollView {
                VStack(spacing: 16) {
                    ForEach(viewModel.groupedExpenseTransactions, id: \.date) { group in
                        TransactionContainerListAndDate(
                            viewModel: transactionViewModel,
                            date: group.date,
                            totalAmount: group.totalAmount,
                            transactions: group.transactions,
                            transactionType: .expense,
                            isEditing: $isEditing,
                            onDelete: { transaction in
                                transactionToDelete = transaction
                            }
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
        .sheet(item: $transactionToDelete) { transaction in
            DeleteConfirmationSheet(
                transaction: transaction,
                onDelete: {
                    viewModel.delete(transaction: transaction)
                    isEditing = false
                    transactionToDelete = nil
                },
                onCancel: {
                    isEditing = false
                    transactionToDelete = nil
                }
            )
            .presentationDetents([.fraction(0.26)])
        }
        .navigationTitle("Expenses")
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            ToolbarItem(placement: .navigationBarTrailing) {
                Button(isEditing ? "Done" : "Edit") {
                    isEditing.toggle()
                }
            }
        }
    }
}

#Preview {
    ExpenseTransactionsView()
        .environmentObject(MoneyViewModel())
        .environmentObject(CurrencySettings())
}
