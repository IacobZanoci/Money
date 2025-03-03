//
//  HomeView.swift
//  Money
//
//  Created by Iacob Zanoci on 29/10/2024.
//

import SwiftUI

struct HomeView: View {
    
    @EnvironmentObject var viewModel: MoneyViewModel
    @EnvironmentObject var currencySettingsViewModel: CurrencySettingsViewModel
    @StateObject private var amountFormatterViewModel = AmountFormatterViewModel()
    
    @State private var isShowingAddRecordSheet = false
    @State private var selectedRecordType: RecordType = .expense
    @State private var showInfoSheet = false
    @State private var sheetHeight: CGFloat = .zero
    
    var body: some View {
        NavigationStack {
            ZStack {
                Color.theme.background.ignoresSafeArea()
                
                VStack(spacing: 10) {
                    headerHomeView
                        .padding(.horizontal)
                    
                    ScrollView {
                        VStack(spacing: 30) {
                            spendingTrackerView
                            spendingMonthlySectionView
                            incomeMonthlyView
                        }
                        .padding()
                    }
                    .scrollIndicators(.hidden)
                }
            }
            .onAppear {
                viewModel.fetchTransactions()
            }
            .ignoresSafeArea(edges: .bottom)
        }
    }
}

extension HomeView {
    
    private var headerHomeView: some View {
        ZStack {
            VStack {
                Text("money")
                    .font(.system(size: 20, weight: .bold, design: .rounded))
                    .foregroundStyle(Color.theme.green)
            }
            .frame(maxWidth: .infinity, alignment: .leading)
            
            VStack {
                Text(viewModel.currentFormattedDate)
                    .font(.system(size: 12, weight: .semibold, design: .default))
                    .foregroundStyle(Color.theme.green)
                    .padding(.vertical, 10)
                    .padding(.horizontal, 24)
                    .background(
                        RoundedRectangle(cornerRadius: 25)
                            .foregroundStyle(Color.theme.green.opacity(0.15))
                    )
            }
            .frame(maxWidth: .infinity, alignment: .center)
            
            
            HStack(alignment: .center, spacing: 24) {
                
                Button(action: {
                    HapticManager.instance.impact(style: .medium)
                    selectedRecordType = .expense
                    isShowingAddRecordSheet.toggle()
                }) {
                    Image(systemName: "plus")
                        .font(.system(size: 20))
                        .foregroundStyle(Color.theme.accent)
                }
                .sheet(isPresented: $isShowingAddRecordSheet) {
                    AddRecordView(selectedRecordType: $selectedRecordType)
                        .environmentObject(viewModel)
                }
            }
            .frame(maxWidth: .infinity, alignment: .trailing)
        }
        .frame(maxWidth: .infinity)
        .padding(.top, 6)
    }
    
    private var spendingTrackerView: some View {
        VStack {
            VStack(spacing: 8) {
                ZStack {
                    Text("Spending Tracker")
                        .font(.system(size: 16, weight: .semibold, design: .default))
                        .foregroundStyle(Color.theme.accent)
                    
                    HStack {
                        Spacer()
                        Button(action: {
                            showInfoSheet = true
                        }) {
                            CircleButtonView(iconName: "questionmark.circle")
                        }
                        .sheet(isPresented: $showInfoSheet) {
                            ZStack {
                                Color.theme.cardColor
                                    .edgesIgnoringSafeArea(.all)
                                
                                VStack {
                                    InfoSpendingTrackerCard()
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
                
                HStack(alignment: .firstTextBaseline, spacing: 4) {
                    let balance = viewModel.monthBalance
                    Text(currencySettingsViewModel.selectedCurrency)
                        .font(.system(size: 25, weight: .semibold, design: .rounded))
                        .foregroundStyle(balance.isPositive ? Color.theme.green.opacity(0.8) : Color.theme.red.opacity(0.8))
                    
                    Text(amountFormatterViewModel.formattedAmount(balance.amount))
                        .font(.system(size: 32, weight: .semibold, design: .rounded))
                        .foregroundStyle(balance.isPositive ? Color.theme.green : Color.theme.red)
                }
                .padding(.bottom, 16)
            }
            
            HStack(spacing: 16) {
                VStack(alignment: .leading, spacing: 4) {
                    VStack(alignment: .leading, spacing: 4) {
                        HStack(alignment: .firstTextBaseline, spacing: 4) {
                            Text(currencySettingsViewModel.selectedCurrency)
                                .font(.system(size: 14, weight: .medium, design: .rounded))
                                .foregroundStyle(Color.theme.white.opacity(0.85))
                            Text(amountFormatterViewModel.formattedAmount(viewModel.totalIncomeForSelectedMonth))
                                .font(.system(size: 18, weight: .medium, design: .rounded))
                                .foregroundStyle(Color.theme.white)
                        }
                        Text("Earned in \(viewModel.selectedMonth)")
                            .font(.system(size: 12, weight: .medium, design: .default))
                            .foregroundStyle(Color.theme.white)
                    }
                    .padding(.horizontal, 16)
                    .padding(.vertical, 10)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    
                    Image("LineUp")
                        .resizable()
                        .scaledToFit()
                        .frame(maxWidth: .infinity)
                        .padding(.bottom, 16)
                }
                .background(
                    RoundedRectangle(cornerRadius: 13)
                        .fill(
                            LinearGradient(
                                gradient: Gradient(colors: [
                                    Color.theme.green.opacity(0.7),
                                    Color.theme.green
                                ]),
                                startPoint: .leading,
                                endPoint: .trailing
                            )
                        )
                )
                
                
                VStack(alignment: .leading, spacing: 4) {
                    VStack(alignment: .leading, spacing: 4) {
                        HStack(alignment: .firstTextBaseline, spacing: 4) {
                            Text(currencySettingsViewModel.selectedCurrency)
                                .font(.system(size: 14, weight: .medium, design: .rounded))
                                .foregroundStyle(Color.theme.white.opacity(0.85))
                            Text(amountFormatterViewModel.formattedAmount(viewModel.spentToday))
                                .font(.system(size: 18, weight: .medium, design: .rounded))
                                .foregroundStyle(Color.theme.white)
                        }
                        Text("Spent Today")
                            .font(.system(size: 12, weight: .medium, design: .default))
                            .foregroundStyle(Color.theme.white)
                    }
                    .padding(.horizontal, 16)
                    .padding(.vertical, 10)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    
                    Image("LineDown")
                        .resizable()
                        .scaledToFit()
                        .frame(maxWidth: .infinity)
                        .padding(.bottom, 16)
                }
                .background(
                    RoundedRectangle(cornerRadius: 13)
                        .fill(
                            LinearGradient(
                                gradient: Gradient(colors: [
                                    Color.theme.red.opacity(0.7),
                                    Color.theme.red
                                ]),
                                startPoint: .leading,
                                endPoint: .trailing
                            )
                        )
                )
                
            }
        }
        .padding(16)
        .background(
            RoundedRectangle(cornerRadius: 16)
                .foregroundStyle(Color.theme.cardColor)
                .shadow(color: Color.black.opacity(0.2), radius: 0, x: 0, y: 0)
                .shadow(color: Color.black.opacity(0.17), radius: 3, x: 0, y: 1.5)
        )
    }
    
    private var spendingMonthlySectionView: some View {
        VStack(spacing: 12) {
            HStack {
                Text("Spending in \(viewModel.selectedMonth)")
                    .font(.system(size: 16, weight: .semibold, design: .default))
                    .foregroundStyle(Color.theme.accent)
                
                Spacer()
                
                NavigationLink(destination: ExpenseTransactionsView()) {
                    ButtonTextChevron(text: "View All")
                }
            }
            
            VStack(spacing: 16) {
                HStack(spacing: 16) {
                    SpendingCategoryCardView(
                        categoryName: "Groceries",
                        iconColor: Color.theme.groceries,
                        type: .expense
                    )
                    
                    SpendingCategoryCardView(
                        categoryName: "Entertainment",
                        iconColor: Color.theme.entertainment,
                        type: .expense
                    )
                }
                
                HStack(spacing: 16) {
                    SpendingCategoryCardView(
                        categoryName: "Shopping",
                        iconColor: Color.theme.shopping,
                        type: .expense
                    )
                    
                    SpendingCategoryCardView(
                        categoryName: "Subscriptions",
                        iconColor: Color.theme.subscription,
                        type: .expense
                    )
                }
                
                HStack(spacing: 16) {
                    SpendingCategoryCardView(
                        categoryName: "Transport",
                        iconColor: Color.theme.transport,
                        type: .expense
                    )
                    
                    SpendingCategoryCardView(
                        categoryName: "Utilities",
                        iconColor: Color.theme.utilities,
                        type: .expense
                    )
                }
                
                HStack(spacing: 16) {
                    SpendingCategoryCardView(
                        categoryName: "Gifts",
                        iconColor: Color.theme.gift,
                        type: .expense
                    )
                    
                    SpendingCategoryCardView(
                        categoryName: "Other",
                        iconColor: Color.theme.other,
                        type: .expense
                    )
                }
            }
        }
    }
    
    private var incomeMonthlyView: some View {
        VStack(alignment: .center, spacing: 12) {
            HStack {
                Text("Income in \(viewModel.selectedMonth)")
                    .font(.system(size: 16, weight: .semibold, design: .default))
                    .foregroundStyle(Color.theme.accent)
                
                Spacer()
                
                if !viewModel.filteredTransactions.isEmpty {
                    NavigationLink(destination: IncomeTransactionsView()) {
                        ButtonTextChevron(text: "View All")
                    }
                }
            }
            
            if !viewModel.filteredTransactions.isEmpty {
                VStack(spacing: 0) {
                    let lastThreeIncomeTransactions = viewModel.filteredTransactions
                        .filter { $0.type == RecordType.income.rawValue }
                        .sorted { ($0.date ?? Date()) > ($1.date ?? Date()) }
                        .prefix(3)
                    
                    ForEach(Array(lastThreeIncomeTransactions.enumerated()), id: \.offset) { index, transaction in
                        IncomeHomeListItemView(
                            iconName: transaction.categoryIcon ?? "ellipsis.circle.fill",
                            title: transaction.categoryName ?? "Other",
                            amount: Float(transaction.amount)
                        )
                        
                        if index != lastThreeIncomeTransactions.count - 1 {
                            Divider()
                                .padding(.vertical, 10)
                                .padding(.horizontal, 16)
                        }
                    }
                }
                .padding(.vertical, 16)
                .background(
                    RoundedRectangle(cornerRadius: 14)
                        .fill(Color.theme.whiteComponent)
                        .overlay(
                            RoundedRectangle(cornerRadius: 14)
                                .stroke(Color.theme.accent.opacity(0.12), lineWidth: 1.5)
                        )
                )
            } else {
                VStack(spacing: 20) {
                    Image(systemName: "chart.bar.fill")
                        .resizable()
                        .scaledToFit()
                        .foregroundStyle(Color.theme.green)
                        .frame(width: 50)
                    
                    Text("Enter your income to easily monitor your earnings and keep your budget balanced.")
                        .font(.system(size: 12, weight: .regular, design: .rounded))
                        .foregroundStyle(Color.theme.accent.opacity(0.8))
                        .multilineTextAlignment(.center)
                        .lineSpacing(6)
                    
                    Button(action: {
                        HapticManager.instance.impact(style: .medium)
                        selectedRecordType = .income
                        isShowingAddRecordSheet.toggle()
                    }) {
                        RoundedButtonTextView(text: "Add income")
                    }
                    .sheet(isPresented: $isShowingAddRecordSheet) {
                        AddRecordView(selectedRecordType: $selectedRecordType)
                            .environmentObject(viewModel)
                    }
                }
                .frame(maxWidth: .infinity)
                .padding(16)
                .background(
                    RoundedRectangle(cornerRadius: 14)
                        .fill(Color.theme.whiteComponent)
                        .overlay(
                            RoundedRectangle(cornerRadius: 14)
                                .stroke(Color.theme.accent.opacity(0.12), lineWidth: 1.5)
                        )
                )
            }
        }
    }
}

#Preview {
    HomeView()
        .environmentObject(MoneyViewModel())
        .environmentObject(CurrencySettingsViewModel())
}
