//
//  IncomeTransactionsView.swift
//  Money
//
//  Created by Iacob Zanoci on 21/12/2024.
//

import SwiftUI

struct IncomeTransactionsView: View {
    @EnvironmentObject var viewModel: MoneyViewModel
    @StateObject var transactionViewModel = TransactionViewModel()
    
    @State private var isMonthPickerPresented: Bool = false
    @State private var isEditing: Bool = false
    @State private var transactionToDelete: Transaction? = nil
    
    var body: some View {
        VStack {
            TransactionMonthAmountView(
                selectedMonth: $viewModel.selectedMonth,
                selectedYear: $viewModel.selectedYear,
                totalAmount: .constant(viewModel.totalIncomeForSelectedMonth),
                isMonthPickerPresented: $isMonthPickerPresented,
                transactionType: .income
            )
            .padding(.horizontal)
            .padding(.top, 10)
            
            ScrollView {
                VStack(spacing: 16) {
                    ForEach(viewModel.groupedIncomeTransactions, id: \.date) { group in
                        TransactionContainerListAndDate(
                            viewModel: transactionViewModel,
                            date: group.date,
                            totalAmount: "+ $\(String(format: "%.2f", group.totalAmount))",
                            transactions: group.transactions,
                            transactionType: .income,
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
        .navigationTitle("Income")
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
    IncomeTransactionsView()
        .environmentObject(MoneyViewModel())
}
