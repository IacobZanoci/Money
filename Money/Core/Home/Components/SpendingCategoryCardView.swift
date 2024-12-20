//
//  SpendingCategoryCardView.swift
//  Money
//
//  Created by Iacob Zanoci on 31/10/2024.
//

import SwiftUI

struct SpendingCategoryCardView: View {
    @EnvironmentObject var moneyViewModel: MoneyViewModel // Access ViewModel
    
    let categoryName: String
    let type: RecordType
    let gradient: LinearGradient
    
    var body: some View {
        HStack(alignment: .center, spacing: 10) {
            Image(systemName: iconName(for: categoryName))
                .foregroundStyle(Color.theme.white)
                .font(.system(size: 18))
                .frame(width: 8, height: 8)
                .padding()
                .background(
                    RoundedRectangle(cornerRadius: 6)
                        .fill(gradient)
                )
            
            VStack(alignment: .leading, spacing: 4) {
                Text(categoryName)
                    .font(.system(size: 12, weight: .medium, design: .default))
                    .foregroundStyle(Color.theme.accent.opacity(0.8))
                
                Text(String(format: "$%.2f", moneyViewModel.totalAmount(forCategory: categoryName, type: type)))
                    .font(.system(size: 14, weight: .medium, design: .rounded))
                    .foregroundStyle(Color.theme.accent)
            }
            Spacer()
        }
        .padding(.leading, 16)
        .padding(.vertical, 16)
        .background(
            RoundedRectangle(cornerRadius: 14)
                .foregroundStyle(Color.theme.white)
                .shadow(color: Color.black.opacity(0.1), radius: 0, x: 0, y: 0)
                .shadow(color: Color.black.opacity(0.1), radius: 1.5)
        )
        .frame(maxWidth: .infinity, alignment: .leading)
    }
    
    private func iconName(for category: String) -> String {
        switch category {
        case "Food": return "fork.knife"
        case "Entertainment": return "figure"
        case "Shopping": return "bag.fill"
        case "Subscriptions": return "creditcard.fill"
        case "Transport": return "car.fill"
        case "Other": return "ellipsis.circle.fill"
        default: return "questionmark.circle.fill"
        }
    }
}

#Preview {
    SpendingCategoryCardView(
        categoryName: "Food",
        type: .expense,
        gradient: LinearGradient(colors: [Color.theme.food.opacity(0.5), Color.theme.food], startPoint: .bottomLeading, endPoint: .topTrailing)
    )
    .environmentObject(MoneyViewModel())
}
