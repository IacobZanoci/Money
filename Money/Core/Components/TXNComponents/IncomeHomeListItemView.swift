//
//  IncomeHomeListItemView.swift
//  Money
//
//  Created by Iacob Zanoci on 21/12/2024.
//

import SwiftUI

struct IncomeHomeListItemView: View {
    
    @EnvironmentObject var moneyViewModel: MoneyViewModel
    @EnvironmentObject var currencySettings: CurrencySettings
    
    let iconName: String
    let title: String
    let amount: Double
    
    var body: some View {
        HStack {
            HStack(spacing: 7) {
                ZStack {
                    Circle()
                        .fill(Color.theme.green)
                        .frame(width: 30, height: 30)
                        .overlay(
                            Image(systemName: iconName)
                                .font(.system(size: 14.5))
                                .foregroundStyle(Color.theme.white)
                        )
                }
                
                Text(title)
                    .font(.system(size: 12, weight: .medium, design: .default))
                    .foregroundStyle(Color.theme.accent)
            }
            Spacer()
            HStack(alignment: .firstTextBaseline, spacing: 4) {
                Text("+ \(currencySettings.selectedCurrency)")
                    .font(.system(size: 12, weight: .medium, design: .rounded))
                    .foregroundStyle(Color.theme.accent.opacity(0.7))
                Text(String(format: "%.2f", amount))
                    .font(.system(size: 14, weight: .medium, design: .rounded))
                    .foregroundStyle(Color.theme.accent)
            }
        }
        .padding(.horizontal)
    }
}

#Preview {
    IncomeHomeListItemView(
        iconName: "briefcase.fill",
        title: "Salary",
        amount: 3300
    )
    .environmentObject(CurrencySettings())
    .environmentObject(CurrencySettings())
}
