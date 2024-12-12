//
//  AddRecordView.swift
//  Money
//
//  Created by Iacob Zanoci on 04/11/2024.
//

import SwiftUI

struct AddRecordView: View {
    @EnvironmentObject var moneyViewModel: MoneyViewModel
    @State private var expenseCount: String? = ""
    @State private var selectedRecordType: RecordType = .expense
    @Environment(\.dismiss) var dismiss
    
    @FocusState private var isTextFieldFocused: Bool
    
    var body: some View {
        NavigationStack {
            VStack {
                navBarHeader
                
                ScrollView {
                    VStack(spacing: 16) {
                        pickerRecordType
                        ExpenseIncomeCountView
                        Divider()
                        dateAndTimeSection
                        Divider()
                        categorySection
                        Divider()
                    }
                    .padding()
                }
                
                VStack(spacing: 16) {
                    Divider()
                    confirmButton
                        .padding(.horizontal)
                }
                .padding(.bottom, 10)
            }
            .onAppear {
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
                    isTextFieldFocused = true
                }
            }
            .onTapGesture {
                isTextFieldFocused = false
            }
        }
    }
}

extension AddRecordView {
    private var navBarHeader: some View {
        HStack {
            AddRecordNavBarButton(icon: "xmark") {
                dismiss()
            }
            
            Spacer()
            
            Text("Add Record")
                .font(.system(size: 16, weight: .medium, design: .default))
                .foregroundStyle(Color.theme.accent)
            
            Spacer()
        }
        .padding(.vertical, 14)
        .padding(.horizontal)
        .background(
            Rectangle()
                .fill(Color.theme.white)
                .shadow(color: Color.theme.accent.opacity(0.3), radius: 0, x: 0, y: 0.8)
        )
    }
    
    private var pickerRecordType: some View {
        Picker("Record Type", selection: $selectedRecordType) {
            ForEach(RecordType.allCases) { recordType in
                Text(recordType.rawValue.capitalized)
                    .tag(recordType)
            }
        }
        .pickerStyle(SegmentedPickerStyle())
    }
    
    private var ExpenseIncomeCountView: some View {
        HStack {
            Text("Expense")
                .font(.system(size: 16, weight: .semibold, design: .default))
                .foregroundStyle(Color.theme.accent)
            
            Spacer()
            
            HStack(spacing: 0) {
                Text("- $ ")
                    .font(.system(size: 32, weight: .semibold, design: .rounded))
                    .foregroundColor(Color.theme.red)
                
                TextField("0", text: Binding(
                    get: { expenseCount ?? "0" }, // Provide a default value if nil
                    set: { expenseCount = $0 }
                ))
                .font(.system(size: 32, weight: .semibold, design: .default))
                .foregroundColor(Color.theme.accent)
                .keyboardType(.decimalPad)
                .multilineTextAlignment(.trailing)
                .fixedSize()
                .focused($isTextFieldFocused)
            }
        }
        .padding(.vertical, 30)
        .padding(.horizontal)
        .background(
            RoundedRectangle(cornerRadius: 12)
                .foregroundStyle(Color.theme.white)
                .shadow(color: Color.black.opacity(0.07), radius: 0, x: 0, y: 0)
                .shadow(color: Color.black.opacity(0.10), radius: 8, x: 0, y: 1.5)
        )
        .overlay(
            RoundedRectangle(cornerRadius: 12)
                .stroke(Color.theme.red.opacity(0.5), lineWidth: 1.2)
        )
    }
    
    private var dateAndTimeSection: some View {
        HStack {
            HStack {
                Image(systemName: "calendar.badge.clock")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 40, height: 32)
                    .symbolRenderingMode(.palette)
                    .foregroundStyle(Color.theme.accent, Color.theme.red)
                
                Text("Date & Time")
                    .font(.system(size: 14, weight: .medium, design: .default))
                    .foregroundStyle(Color.theme.accent)
            }
            .padding(.leading, 6)
            
            Spacer()
            
            Text("Today, 11:29 pm")
                .font(.system(size: 14, weight: .medium, design: .default))
                .foregroundStyle(Color.theme.accent.opacity(0.7))
        }
    }
    
    private var categorySection: some View {
        HStack {
            HStack {
                Image(systemName: "chart.bar.yaxis")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 33, height: 32)
                    .symbolRenderingMode(.palette)
                    .foregroundStyle(Color.theme.red, Color.theme.accent)
                
                Text("Category")
                    .font(.system(size: 14, weight: .medium, design: .default))
                    .foregroundStyle(Color.theme.accent)
            }
            .padding(.leading, 6)
            
            Spacer()
            
            HStack {
                Text("General")
                    .font(.system(size: 14, weight: .medium, design: .default))
                    .foregroundStyle(Color.theme.accent.opacity(0.7))
                
                Image(systemName: "chevron.forward")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 8.5, height: 12)
                    .foregroundStyle(Color.theme.accent.opacity(0.7))
            }
        }
    }
    
    private var confirmButton: some View {
        Button(action: {
            guard let amount = Float(expenseCount ?? ""), amount > 0 else {
                // Handle invalid input (e.g., show an alert)
                return
            }
            
            if selectedRecordType == .expense {
                moneyViewModel.addSpentMoney(amount: amount)
            } else {
                moneyViewModel.addEarnedMoney(amount: amount)
            }
            
            dismiss() // Close the sheet
        }) {
            HStack {
                Spacer()
                Text("Confirm")
                    .font(.system(size: 14, weight: .medium))
                    .foregroundStyle(Color.theme.white)
                Spacer()
                Image(systemName: "checkmark")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 15, height: 15)
                    .foregroundStyle(Color.theme.white)
            }
            .padding(.vertical, 14)
            .padding(.horizontal)
            .background(
                RoundedRectangle(cornerRadius: 10)
                    .fill(Color.theme.accent.opacity(0.3)) // Adjust fill for clarity
            )
        }
        .frame(maxWidth: .infinity)
    }
}

enum RecordType: String, CaseIterable, Identifiable {
    case expense
    case income
    
    var id: String { self.rawValue }
}

#Preview {
    AddRecordView()
        .environmentObject(MoneyViewModel())
}
