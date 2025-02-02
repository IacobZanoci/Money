//
//  ExpenseTransactionsView.swift
//  Money
//
//  Created by Iacob Zanoci on 21/12/2024.
//

import SwiftUI

struct ExpenseTransactionsView: View {
    @EnvironmentObject var viewModel: MoneyViewModel
    @EnvironmentObject var currencySettingsViewModel: CurrencySettingsViewModel
    
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
            
            ZStack {
                if viewModel.groupedExpenseTransactions.isEmpty {
                    VStack(spacing: 10) {
                        Image(systemName: "tray.full.fill")
                            .font(.system(size: 40))
                            .foregroundStyle(Color.theme.accent.opacity(0.75))
                        
                        Text("No transactions")
                            .font(.system(size: 14, weight: .semibold, design: .rounded))
                            .foregroundStyle(Color.theme.accent.opacity(0.75))
                    }
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                }
                
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
        }
        .sheet(isPresented: $isMonthPickerPresented) {
            MonthYearPicker(selectedMonth: $viewModel.selectedMonth, selectedYear: $viewModel.selectedYear, viewModel: viewModel)
                .presentationDetents([.medium, .fraction(0.3)])
                .presentationDragIndicator(.visible)
        }
        .sheet(item: $transactionToDelete, onDismiss: {
            isEditing = false
        }) { transaction in
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
        .navigationBarBackButtonHidden(true)
        .toolbar {
            ToolbarItem(placement: .navigationBarLeading) {
                BackNavigationCircleButton()
            }
            
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
        .environmentObject(CurrencySettingsViewModel())
}
