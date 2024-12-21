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
        VStack {
            Text("Expense Transactions")
                .font(.title)
                .padding()
            
            List {
                ForEach(moneyViewModel.transactions.filter { $0.type == RecordType.expense.rawValue }, id: \.objectID) { transaction in
                    HStack {
                        VStack(alignment: .leading, spacing: 4) {
                            Text(transaction.categoryName ?? "Unknown")
                                .font(.headline)
                            Text("\(transaction.date ?? Date(), formatter: dateFormatter)")
                                .font(.subheadline)
                                .foregroundColor(.gray)
                        }
                        
                        Spacer()
                        
                        Text("$\(transaction.amount, specifier: "%.2f")")
                            .font(.body)
                            .foregroundColor(Color.theme.red)
                    }
                    .padding(.vertical, 4)
                }
            }
        }
        .navigationTitle("Expenses")
        .navigationBarTitleDisplayMode(.inline)
    }
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
