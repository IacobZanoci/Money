//
//  IncomeHomeListItemView.swift
//  Money
//
//  Created by Iacob Zanoci on 21/12/2024.
//

import SwiftUI

struct IncomeHomeListItemView: View {
    
    @EnvironmentObject var moneyViewModel: MoneyViewModel
    
    let iconName: String
    let title: String
    let incomeAmount: String
    
    var body: some View {
        HStack {
            HStack(spacing: 7) {
                Image(systemName: iconName)
                    .resizable()
                    .scaledToFit()
                    .foregroundStyle(Color.theme.green)
                    .frame(width: 30)
                
                Text(title)
                    .font(.system(size: 12, weight: .medium, design: .default))
                    .foregroundStyle(Color.theme.accent)
            }
            Spacer()
            VStack {
                Text(incomeAmount)
                    .font(.system(size: 14, weight: .medium, design: .rounded))
                    .foregroundStyle(Color.theme.green)
            }
        }
        .padding(.horizontal)
    }
}

#Preview {
    IncomeHomeListItemView(iconName: "briefcase.circle.fill", title: "Salary", incomeAmount: "+ $ 3 300")
        .environmentObject(MoneyViewModel())
}
