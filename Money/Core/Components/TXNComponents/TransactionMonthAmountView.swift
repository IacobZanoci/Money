//
//  TransactionMonthAmountView.swift
//  Money
//
//  Created by Iacob Zanoci on 26/12/2024.
//

import SwiftUI

enum TransactionType {
    case expense
    case income
}

struct TransactionMonthAmountView: View {
    @Binding var selectedMonth: String
    @Binding var selectedYear: String
    @Binding var totalAmount: Float
    @Binding var isMonthPickerPresented: Bool
    var transactionType: TransactionType
    
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
                
                Text("\(transactionType == .expense ? "- $" : "+ $") \(totalAmount, specifier: "%.2f")")
                    .font(.system(size: 16, weight: .semibold, design: .rounded))
                    .foregroundStyle(transactionType == .expense ? Color.theme.red : Color.theme.green)
            }
        }
        .padding()
        .background(
            RoundedRectangle(cornerRadius: 14)
                .fill(Color.theme.monthAmountBG)
                .overlay(
                    RoundedRectangle(cornerRadius: 14)
                        .stroke(Color.theme.accent.opacity(0.12), lineWidth: 1.5)
                )
        )
    }
}


struct TransactionMonthAmountView_Previews: PreviewProvider {
    static var previews: some View {
        
        @State var selectedMonth: String = "January"
        @State var selectedYear: String = "2025"
        @State var totalAmount: Float = 250.00
        @State var isMonthPickerPresented: Bool = false

        return TransactionMonthAmountView(
            selectedMonth: $selectedMonth,
            selectedYear: $selectedYear,
            totalAmount: $totalAmount,
            isMonthPickerPresented: $isMonthPickerPresented,
            transactionType: .expense
        )
        .previewLayout(.sizeThatFits)
        .padding()
    }
}
