//
//  ExpenseTransactionsView.swift
//  Money
//
//  Created by Iacob Zanoci on 21/12/2024.
//

import SwiftUI

struct ExpenseTransactionsView: View {
    @EnvironmentObject var moneyViewModel: MoneyViewModel
    
    var body: some View {
        ScrollView {
            VStack(spacing: 16) {
                ForEach(moneyViewModel.groupedExpenseTransactions, id: \.date) { group in
                    ExpenseContainerListAndDate(
                        date: group.date,
                        totalAmount: "- $\(String(format: "%.2f", group.totalAmount))",
                        transactions: group.transactions
                    )
                }
            }
            .padding()
        }
        .navigationTitle("Expenses")
        .navigationBarTitleDisplayMode(.inline)
    }
}

#Preview {
    ExpenseTransactionsView()
        .environmentObject(MoneyViewModel())
}

private let dateFormatter: DateFormatter = {
    let formatter = DateFormatter()
    formatter.dateStyle = .medium
    formatter.timeStyle = .none
    return formatter
}()

#Preview {
    ExpenseTransactionsView()
        .environmentObject(MoneyViewModel())
}
