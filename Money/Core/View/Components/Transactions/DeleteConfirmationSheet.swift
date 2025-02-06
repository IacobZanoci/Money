//
//  DeleteConfirmationSheet.swift
//  Money
//
//  Created by Iacob Zanoci on 15/01/2025.
//

import SwiftUI

struct DeleteConfirmationSheet: View {
    @StateObject var viewModel = MoneyViewModel()
    @EnvironmentObject var currencySettingsViewModel: CurrencySettingsViewModel
    @StateObject private var amountFormatterViewModel = AmountFormatterViewModel()
    
    let transaction: Transaction
    let onDelete: () -> Void
    let onCancel: () -> Void
    
    var body: some View {
        VStack(spacing: 20) {
            VStack(spacing: 5) {
                HStack {
                    Text("Delete ‘\(transaction.categoryName ?? "this transaction")’ ?")
                        .font(.system(size: 16, weight: .semibold, design: .rounded))
                        .foregroundStyle(Color.theme.accent)
                    Spacer()
                    HStack(alignment: .firstTextBaseline, spacing: 4) {
                        Text(currencySettingsViewModel.selectedCurrency)
                            .font(.system(size: 12, weight: .medium, design: .rounded))
                            .foregroundStyle(Color.theme.accent.opacity(0.85))
                        Text(amountFormatterViewModel.formattedAmount(transaction.amount))
                            .font(.system(size: 14, weight: .semibold, design: .rounded))
                            .foregroundStyle(Color.theme.accent)
                    }
                }
                HStack {
                    Text("This action cannot be undone.")
                        .font(.system(size: 16, weight: .semibold, design: .rounded))
                        .foregroundStyle(Color.theme.accent).opacity(0.5)
                    Spacer()
                    Text(DateFormatterUtility.formatTime(transaction.date ?? Date()))
                        .font(.system(size: 14, weight: .semibold, design: .rounded))
                        .foregroundStyle(Color.theme.accent.opacity(0.75))
                    
                }
            }
            VStack(spacing: 10) {
                Button(action: {
                    onDelete()
                    HapticManager.instance.impact(style: .heavy)
                }) {
                    Text("Delete")
                        .font(.system(size: 14, weight: .medium, design: .default))
                        .foregroundColor(Color.theme.white)
                        .padding(.vertical, 12)
                        .frame(maxWidth: .infinity)
                        .background(
                            RoundedRectangle(cornerRadius: 10)
                                .fill(Color.theme.red)
                        )
                        .contentShape(Rectangle())
                }
                
                Button(action: {
                    onCancel()
                }) {
                    Text("Cancel")
                        .font(.system(size: 14, weight: .medium, design: .default))
                        .foregroundColor(Color.theme.accent)
                        .padding(.vertical, 12)
                        .frame(maxWidth: .infinity)
                        .background(
                            RoundedRectangle(cornerRadius: 10)
                                .fill(Color.theme.cancelButton)
                        )
                        .contentShape(Rectangle())
                }
            }
        }
        .padding()
    }
}
