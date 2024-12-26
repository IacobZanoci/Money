//
//  TransactionMonthAmountView.swift
//  Money
//
//  Created by Iacob Zanoci on 26/12/2024.
//

import SwiftUI

struct TransactionMonthAmountView: View {
    @Binding var selectedMonth: String
    @Binding var selectedYear: String
    @Binding var totalSpent: Float
    @Binding var isMonthPickerPresented: Bool
    
    var body: some View {
        VStack {
            HStack {
                Button(action: { isMonthPickerPresented.toggle() }) {
                    HStack {
                        Text("\(selectedMonth) \(selectedYear)")
                            .font(.system(size: 16, weight: .semibold, design: .rounded))
                            .foregroundStyle(Color.theme.accent)
                        
                        Image(systemName: "chevron.down")
                            .resizable()
                            .scaledToFit()
                            .foregroundStyle(Color.theme.accent)
                            .frame(width: 10)
                    }
                }
                
                Spacer()
                
                Text("- $ \(totalSpent, specifier: "%.2f")")
                    .font(.system(size: 16, weight: .semibold, design: .rounded))
                    .foregroundStyle(Color.theme.red)
            }
        }
        .padding()
        .background(
            RoundedRectangle(cornerRadius: 14)
                .foregroundStyle(Color.theme.accent.opacity(0.05))
                .shadow(color: Color.black.opacity(0.1), radius: 0, x: 0, y: 0)
                .shadow(color: Color.black.opacity(0.1), radius: 1.5)
        )
    }
}
