//
//  ExpenseTransactionItemView.swift
//  Money
//
//  Created by Iacob Zanoci on 26/12/2024.
//

import SwiftUI

struct ExpenseTransactionItemView: View {
    let icon: String
    let title: String
    let time: String
    let amount: String
    
    var body: some View {
        HStack(alignment: .firstTextBaseline) {
            HStack(spacing: 10) {
                Image(systemName: icon)
                    .resizable()
                    .scaledToFit()
                    .foregroundStyle(Color.theme.red)
                    .frame(width: 30)
                
                VStack(alignment: .leading) {
                    Text(title)
                        .font(.system(size: 12, weight: .medium, design: .default))
                        .foregroundStyle(Color.theme.accent)
                    Text(time)
                        .font(.system(size: 10, weight: .medium, design: .rounded))
                        .foregroundStyle(Color.theme.accent).opacity(0.5)
                }
            }
            
            Spacer()
            
            VStack {
                Text(amount)
                    .font(.system(size: 12, weight: .semibold, design: .rounded))
                    .foregroundStyle(Color.theme.red).opacity(0.8)
            }
        }
    }
}

#Preview {
    ExpenseTransactionItemView(icon: "fork.knife.circle.fill",
                               title: "Food",
                               time: "9:45 am",
                               amount: "- $ 11.32"
    )
    .environmentObject(MoneyViewModel())
}
