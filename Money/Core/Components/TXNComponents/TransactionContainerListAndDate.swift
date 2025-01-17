//
//  TransactionContainerListAndDate.swift
//  Money
//
//  Created by Iacob Zanoci on 26/12/2024.
//

import SwiftUI

struct TransactionContainerListAndDate: View {
    @EnvironmentObject var moneyViewModel: MoneyViewModel
    @EnvironmentObject var currencySettings: CurrencySettings
    
    @ObservedObject var viewModel: TransactionViewModel
    
    let date: String
    let totalAmount: Float
    let transactions: [Transaction]
    let transactionType: TransactionType
    @Binding var isEditing: Bool
    let onDelete: (Transaction) -> Void
    
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
                
                HStack(alignment: .firstTextBaseline, spacing: 4) {
                    Text("\(transactionType == .expense ? "- " : "+ ")\(currencySettings.selectedCurrency)")
                        .font(.system(size: 12, weight: .semibold, design: .rounded))
                        .foregroundStyle(Color.theme.accent.opacity(0.85))
                    Text(String(format: "%.2f", totalAmount))
                        .font(.system(size: 14, weight: .semibold, design: .rounded))
                        .foregroundStyle(Color.theme.accent.opacity(0.9))
                }
            }
            .padding(.bottom, 6)
            
            Divider()
                .padding(.trailing, -16)
            
            ForEach(transactions.sorted { ($0.date ?? Date()) > ($1.date ?? Date()) }, id: \.objectID) { transaction in
                HStack(alignment: .center) {
                    if isEditing {
                        Button(action: {
                            onDelete(transaction)
                        }) {
                            Image(systemName: "minus.circle.fill")
                                .font(.system(size: 20))
                                .foregroundColor(.red)
                                .frame(width: 24, height: 24)
                                .padding(.top, 9)
                        }
                        .padding(.trailing, 0)
                        .opacity(viewModel.slideIn ? 1 : 0)
                        .animation(.easeIn(duration: 0.3), value: viewModel.slideIn)
                    }
                    
                    TransactionItemView(
                        icon: transaction.categoryIcon ?? "questionmark.circle.fill",
                        title: transaction.categoryName ?? "Unknown",
                        time: timeFormatter.string(from: transaction.date ?? Date()),
                        amount: "\(transactionType == .expense ? "-" : "+") \(currencySettings.selectedCurrency) \(String(format: "%.2f", transaction.amount))",
                        color: transactionColor
                    )
                    .padding(.top, 14)
                    .scaleEffect(isEditing ? 0.95 : 1)
                    .animation(.easeInOut(duration: 0.3), value: isEditing)
                }
                .onAppear {
                    viewModel.triggerSlideIn()
                }
                .onChange(of: isEditing) { newValue in
                    withAnimation(.easeInOut(duration: 0.3)) {
                        viewModel.slideIn = newValue
                    }
                }
            }
        }
        .padding()
        .background(
            RoundedRectangle(cornerRadius: 14)
                .fill(Color.theme.whiteComponent)
                .overlay(
                    RoundedRectangle(cornerRadius: 14)
                        .stroke(Color.theme.accent.opacity(0.12), lineWidth: 1.5)
                )
        )
    }
}
