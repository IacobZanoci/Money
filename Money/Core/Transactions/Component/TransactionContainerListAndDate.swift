//
//  TransactionContainerListAndDate.swift
//  Money
//
//  Created by Iacob Zanoci on 26/12/2024.
//

import SwiftUI

struct TransactionContainerListAndDate: View {
    @EnvironmentObject var moneyViewModel: MoneyViewModel
    
    let date: String
    let totalAmount: String
    let transactions: [Transaction]
    let transactionType: TransactionType
    
    private var timeFormatter: DateFormatter {
        let formatter = DateFormatter()
        formatter.dateFormat = "h:mm a"
        return formatter
    }
    
    private var transactionColor: Color {
        transactionType == .expense ? Color.theme.red : Color.theme.green
    }
    
    var body: some View {
        VStack {
            HStack {
                Text(date)
                    .font(.system(size: 16, weight: .semibold, design: .rounded))
                    .foregroundStyle(Color.theme.accent)
                
                Spacer()
                
                Text(totalAmount)
                    .font(.system(size: 14, weight: .semibold, design: .rounded))
                    .foregroundStyle(Color.theme.accent).opacity(0.5)
            }
            
            Divider()
                .padding(.top, 10)
            
            // Display all transactions for the day, sorted by date (most recent first)
            ForEach(transactions.sorted { ($0.date ?? Date()) > ($1.date ?? Date()) }, id: \.objectID) { transaction in
                TransactionItemView(
                    icon: transaction.categoryIcon ?? "questionmark.circle.fill",
                    title: transaction.categoryName ?? "Unknown",
                    time: timeFormatter.string(from: transaction.date ?? Date()),
                    amount: "\(transactionType == .expense ? "-" : "+") $\(String(format: "%.2f", transaction.amount))",
                    color: transactionColor
                )
                .padding(.top, 10)
            }
        }
        .padding()
        .background(
            RoundedRectangle(cornerRadius: 14)
                .foregroundStyle(Color.theme.white)
                .shadow(color: Color.black.opacity(0.1), radius: 0, x: 0, y: 0)
                .shadow(color: Color.black.opacity(0.1), radius: 1.5)
        )
    }
}
