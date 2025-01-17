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
    
    @EnvironmentObject var currencySettings: CurrencySettings
    
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
                
                HStack(alignment: .firstTextBaseline, spacing: 4) {
                    Text("\(transactionType == .expense ? "- " : "+ ")\(currencySettings.selectedCurrency)")
                        .font(.system(size: 14, weight: .semibold, design: .rounded))
                        .foregroundStyle(transactionType == .expense
                                         ? Color.theme.red.opacity(0.7)
                                         : Color.theme.green.opacity(0.7)
                        )
                    Text(String(format: "%.2f", totalAmount))
                        .font(.system(size: 16, weight: .semibold, design: .rounded))
                        .foregroundStyle(transactionType == .expense
                                         ? Color.theme.red
                                         : Color.theme.green
                        )
                }
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
        .environmentObject(CurrencySettings())
        .previewLayout(.sizeThatFits)
        .padding()
    }
}

