//
//  IncomeTransactionsView.swift
//  Money
//
//  Created by Iacob Zanoci on 21/12/2024.
//

import SwiftUI

struct IncomeTransactionsView: View {
    
    @EnvironmentObject var moneyViewModel: MoneyViewModel
    
    var body: some View {
        VStack {
            Text("Income Transactions")
                .font(.title)
                .padding()
            
            List {
                ForEach(moneyViewModel.transactions.filter { $0.type == RecordType.income.rawValue }, id: \.objectID) { transaction in
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
                            .foregroundColor(Color.theme.green)
                    }
                    .padding(.vertical, 4)
                }
            }
        }
        .navigationTitle("Income")
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
    IncomeTransactionsView()
        .environmentObject(MoneyViewModel())
}
