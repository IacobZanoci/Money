//
//  SpendingCategoryCardView.swift
//  Money
//
//  Created by Iacob Zanoci on 31/10/2024.
//

import SwiftUI

struct SpendingCategoryCardView: View {
    @EnvironmentObject var moneyViewModel: MoneyViewModel
    @EnvironmentObject var currencySettings: CurrencySettings
    
    let categoryName: String
    let iconColor: Color
    let type: RecordType
    
    var body: some View {
        HStack(alignment: .center, spacing: 10) {
            Image(systemName: iconName(for: categoryName))
                .foregroundStyle(iconColor)
                .font(.system(size: 24))
                .frame(width: 8, height: 8)
                .padding()
                .background(
                    RoundedRectangle(cornerRadius: 6)
                        .fill(Color.theme.whiteComponent)
                        .overlay(
                            RoundedRectangle(cornerRadius: 6)
                                .stroke(Color.theme.accent.opacity(0.15), lineWidth: 1.3)
                        )
                )
            
            VStack(alignment: .leading, spacing: 4) {
                Text(categoryName)
                    .font(.system(size: 13, weight: .medium, design: .default))
                    .foregroundStyle(Color.theme.accent.opacity(0.9))
                
                HStack(alignment: .firstTextBaseline, spacing: 4) {
                    Text(currencySettings.selectedCurrency)
                        .font(.system(size: 12, weight: .medium, design: .rounded))
                        .foregroundStyle(Color.theme.accent.opacity(0.85))
                    Text(String(format: "%.2f", moneyViewModel.totalAmount(forCategory: categoryName, type: type)))
                        .font(.system(size: 15, weight: .medium, design: .rounded))
                        .foregroundStyle(Color.theme.accent)
                }
            }
            Spacer()
        }
        .padding(.leading, 16)
        .padding(.vertical, 16)
        .background(
                RoundedRectangle(cornerRadius: 14)
                    .fill(Color.theme.cardColor)
                    .overlay(
                        RoundedRectangle(cornerRadius: 14)
                            .stroke(Color.theme.accent.opacity(0.12), lineWidth: 1.5)
                    )
            )
        .frame(maxWidth: .infinity, alignment: .leading)
    }
    
    private func iconName(for category: String) -> String {
        switch category {
        case "Groceries": return "basket.fill"
        case "Entertainment": return "figure"
        case "Shopping": return "bag.fill"
        case "Subscriptions": return "checkmark.arrow.trianglehead.counterclockwise"
        case "Transport": return "bus.fill"
        case "Utilities": return "lightbulb.fill"
        case "Gifts": return "gift.fill"
        case "Other": return "ellipsis.circle.fill"
        default: return "ellipsis.circle.fill"
        }
    }
}

#Preview {
    SpendingCategoryCardView(
        categoryName: "Groceries",
        iconColor: Color.theme.groceries,
        type: .expense
    )
    .padding()
    .environmentObject(MoneyViewModel())
    .environmentObject(CurrencySettings())
}
