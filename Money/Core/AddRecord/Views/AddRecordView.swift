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
    @State private var selectedDate: Date = Date() // Holds the selected date

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
        CustomNavBar(title: "Add Record",
                     icon: "xmark",
                     iconColor: Color.theme.red,
                     titleColor: Color.theme.accent,
                     borderColor: Color.theme.accent) {
            moneyViewModel.selectedExpenseCategory = ExpenseCategory(name: "General", icon: "chart.bar.yaxis")
            dismiss()
        }
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
            Text(selectedRecordType == .expense ? "Expense" : "Income")
                .font(.system(size: 16, weight: .semibold, design: .default))
                .foregroundStyle(Color.theme.accent)

            Spacer()

            HStack(spacing: 0) {
                Text(selectedRecordType == .expense ? "- $ " : "+ $ ")
                    .font(.system(size: 32, weight: .semibold, design: .rounded))
                    .foregroundColor(selectedRecordType == .expense ? Color.theme.red : Color.theme.green)

                TextField("0", text: Binding(
                    get: { expenseCount ?? "0" },
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

            // Display formatted date & time, and tap to open the date picker
            Button(action: {
                isDatePickerPresented.toggle()
            }) {
                Text(formattedDate)
                    .font(.system(size: 14, weight: .medium, design: .default))
                    .foregroundStyle(Color.theme.accent.opacity(0.7))
            }
            .sheet(isPresented: $isDatePickerPresented) {
                DatePicker(
                    "Select Date & Time",
                    selection: $selectedDate,
                    displayedComponents: [.date, .hourAndMinute]
                )
                .datePickerStyle(WheelDatePickerStyle())
                .presentationDetents([.medium, .large])
                .padding()
            }
        }
    }

    private var categorySection: some View {
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

            Spacer()

            HStack {
                if let selectedCategory = moneyViewModel.selectedExpenseCategory {
                    Text(selectedCategory.name)
                        .font(.system(size: 14, weight: .medium, design: .default))
                        .foregroundStyle(Color.theme.accent.opacity(0.7))
                } else {
                    Text("General")
                        .font(.system(size: 14, weight: .medium, design: .default))
                        .foregroundStyle(Color.theme.accent.opacity(0.7))
                }

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
        .sheet(isPresented: $isCategorySheetPresented, onDismiss: {
            if moneyViewModel.selectedExpenseCategory == nil {
                moneyViewModel.selectedExpenseCategory = ExpenseCategory(name: "General", icon: "chart.bar.yaxis")
            }
        }) {
            ExpenseCategoryListView(viewModel: moneyViewModel)
        }
    }

    private var confirmButton: some View {
        Button(action: {
            guard let amount = Float(expenseCount ?? ""), amount > 0 else {
                return
            }

            moneyViewModel.selectedExpenseCategory = ExpenseCategory(name: "General", icon: "chart.bar.yaxis")

            if selectedRecordType == .expense {
                moneyViewModel.addSpentMoney(amount: amount)
            } else {
                moneyViewModel.addEarnedMoney(amount: amount)
            }
            dismiss()
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
                    .fill(buttonBackgroundColor)
            )
        }
        .frame(maxWidth: .infinity)
        .disabled(Float(expenseCount ?? "") ?? 0 <= 0)
    }

    private var buttonBackgroundColor: Color {
        if let amount = Float(expenseCount ?? ""), amount > 0 {
            return selectedRecordType == .expense ? Color.theme.red : Color.theme.green
        } else {
            return Color.gray.opacity(0.5)
        }
    }

    private var formattedDate: String {
        let calendar = Calendar.current
        let today = calendar.isDateInToday(selectedDate)

        let timeFormatter = DateFormatter()
        timeFormatter.dateStyle = .none
        timeFormatter.timeStyle = .short

        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .medium
        dateFormatter.timeStyle = .none

        if today {
            return "Today at \(timeFormatter.string(from: selectedDate))"
        } else {
            return "\(dateFormatter.string(from: selectedDate)) at \(timeFormatter.string(from: selectedDate))"
        }
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
