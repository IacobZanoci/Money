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
    @State private var isCategorySheetPresented: Bool = false
    @State private var isDatePickerPresented: Bool = false
    @State private var selectedDate: Date = Date()
    @State private var sheetHeight: CGFloat = .zero
    
    var body: some View {
        NavigationStack {
            
            ZStack {
                Color.theme.background.ignoresSafeArea()
                
                VStack {
                    navBarHeader
                        .padding(.top, 16)
                    
                    ScrollView {
                        VStack(spacing: 16) {
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
}

extension AddRecordView {
    private var navBarHeader: some View {
        ZStack() {
            xMarkDismissButton(color: selectedRecordType == .expense ? Color.theme.red.opacity(0.8) : Color.theme.green.opacity(0.8))
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(.leading, 16)
            
            HStack {
                Spacer()
                Picker("Record Type", selection: $selectedRecordType) {
                    ForEach(RecordType.allCases) { recordType in
                        Text(recordType.rawValue.capitalized)
                            .tag(recordType)
                    }
                }
                .pickerStyle(SegmentedPickerStyle())
                .frame(width: 230)
                .clipped()
                Spacer()
            }
            .frame(maxWidth: .infinity, alignment: .center)
        }
    }
    
    private var ExpenseIncomeCountView: some View {
        ZStack {
            VStack {
                Text(selectedRecordType == .expense ? "Expense" : "Income")
                    .font(.system(size: 16, weight: .semibold, design: .default))
                    .foregroundStyle(Color.theme.accent)
            }
            .frame(maxWidth: .infinity, alignment: .leading)
            
            HStack(spacing: 0) {
                Text(selectedRecordType == .expense ? "- $ " : "+ $ ")
                    .font(.system(size: 32, weight: .semibold, design: .rounded))
                    .foregroundColor(selectedRecordType == .expense ? Color.theme.red : Color.theme.green)
                
                TextField(
                    "0",
                    text: Binding(
                        get: { expenseCount ?? "" },
                        set: { newValue in
                            let sanitized = newValue.filter { $0.isNumber || $0 == "." }
                            if sanitized.filter({ $0 == "." }).count > 1 {
                                expenseCount = String(sanitized.dropLast())
                            } else {
                                expenseCount = sanitized
                            }
                        }
                    ).max(7)
                )
                .font(.system(size: 32, weight: .semibold, design: .default))
                .foregroundColor(Color.theme.accent)
                .keyboardType(.decimalPad)
                .multilineTextAlignment(.trailing)
                .fixedSize()
                .focused($isTextFieldFocused)
            }
            .frame(maxWidth: .infinity, alignment: .trailing)
        }
        .frame(maxWidth: .infinity)
        .padding(.vertical, 30)
        .padding(.horizontal)
        .background(
            RoundedRectangle(cornerRadius: 12)
                .foregroundStyle(Color.theme.whiteComponent)
                .shadow(color: Color.black.opacity(0.07), radius: 0, x: 0, y: 0)
                .shadow(color: Color.black.opacity(0.10), radius: 8, x: 0, y: 1.5)
        )
        .overlay(
            RoundedRectangle(cornerRadius: 12)
                .stroke(
                    selectedRecordType == .expense
                    ? Color.theme.red.opacity(0.5)
                    : Color.theme.green.opacity(0.5),
                    lineWidth: 1.2
                )
        )
    }
    
    private var dateAndTimeSection: some View {
        HStack {
            HStack(spacing: 10) {
                Image(systemName: "calendar")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 32, height: 32)
                    .symbolRenderingMode(.palette)
                    .foregroundStyle(selectedRecordType == .expense ? Color.theme.red : Color.theme.green)
                
                Text("Date & Time")
                    .font(.system(size: 14, weight: .medium, design: .default))
                    .foregroundStyle(Color.theme.accent)
            }
            
            Spacer()
            
            Button(action: {
                isDatePickerPresented.toggle()
            }) {
                Text(DateFormatterUtility.formatDateAndTime(selectedDate))
                    .font(.system(size: 14, weight: .medium, design: .default))
                    .foregroundStyle(Color.theme.accent.opacity(0.7))
            }
            .sheet(isPresented: $isDatePickerPresented) {
                ZStack {
                    Color.theme.cardColor
                        .edgesIgnoringSafeArea(.all)
                    
                    VStack {
                        DatePicker(
                            "",
                            selection: $selectedDate,
                            displayedComponents: [.date, .hourAndMinute]
                        )
                        .datePickerStyle(WheelDatePickerStyle())
                        .padding()
                    }
                    .background(Color.theme.cardColor)
                    .overlay {
                        GeometryReader { geometry in
                            Color.clear.preference(key: InnerHeightPreferenceKey.self, value: geometry.size.height)
                        }
                    }
                    .onPreferenceChange(InnerHeightPreferenceKey.self) { newHeight in
                        sheetHeight = newHeight
                    }
                    .presentationDetents([.height(sheetHeight)])
                    .presentationDragIndicator(.visible)
                }
            }
        }
    }
    
    private var categorySection: some View {
        HStack(spacing: 10) {
            Image(systemName: "square.grid.2x2")
                .resizable()
                .scaledToFit()
                .frame(width: 32, height: 32)
                .symbolRenderingMode(.palette)
                .foregroundStyle(selectedRecordType == .expense ? Color.theme.red : Color.theme.green)
            
            Text("Category")
                .font(.system(size: 14, weight: .medium, design: .default))
                .foregroundStyle(Color.theme.accent)
            
            Spacer()
            
            HStack {
                Text(moneyViewModel.selectedCategory(for: selectedRecordType))
                    .font(.system(size: 14, weight: .medium, design: .default))
                    .foregroundStyle(Color.theme.accent.opacity(0.7))
                
                Image(systemName: "chevron.forward")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 8.5, height: 12)
                    .foregroundStyle(Color.theme.accent.opacity(0.7))
            }
        }
        .onTapGesture {
            isCategorySheetPresented = true
        }
        .sheet(isPresented: $isCategorySheetPresented) {
            moneyViewModel.categoryListView(for: selectedRecordType)
        }
    }
    
    private var confirmButton: some View {
        Button(action: {
            guard let amount = Float(expenseCount ?? ""), amount > 0 else {
                return
            }
            
            if selectedRecordType == .expense {
                let selectedCategory = moneyViewModel.selectedExpenseCategory ?? ExpenseCategory(name: "Other", icon: "ellipsis.circle.fill")
                moneyViewModel.addTransaction(
                    amount: -amount,
                    type: .expense,
                    date: selectedDate,
                    category: selectedCategory
                )
            } else {
                let selectedCategory = moneyViewModel.selectedIncomeCategory ?? IncomeCategory(name: "Other", icon: "ellipsis.circle.fill")
                moneyViewModel.addTransaction(
                    amount: amount,
                    type: .income,
                    date: selectedDate,
                    incomeCategory: selectedCategory
                )
            }
            
            moneyViewModel.resetCategory(for: selectedRecordType)
            dismiss()
        }) {
            ZStack {
                Text("Confirm")
                    .font(.system(size: 14, weight: .medium))
                    .foregroundStyle(Color.theme.white)
                HStack {
                    Spacer()
                    Image(systemName: "checkmark")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 15, height: 15)
                        .foregroundStyle(Color.theme.white)
                        .opacity(Float(expenseCount ?? "") ?? 0 > 0 ? 1 : 0)
                }
                
            }
            .frame(maxWidth: .infinity, alignment: .center)
            .padding(.vertical, 14)
            .padding(.horizontal)
            .background(
                RoundedRectangle(cornerRadius: 10)
                    .fill(ButtonBackgroundHelper.getBackgroundColor(for: expenseCount, recordType: selectedRecordType))
            )
        }
        .disabled(Float(expenseCount ?? "") ?? 0 <= 0)
    }
}

#Preview {
    AddRecordView()
        .environmentObject(MoneyViewModel())
}
