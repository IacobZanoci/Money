//
//  HomeView.swift
//  Money
//
//  Created by Iacob Zanoci on 29/10/2024.
//

import SwiftUI

struct HomeView: View {
    
    @EnvironmentObject var moneyViewModel: MoneyViewModel // Access the injected MoneyViewModel
    
    
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
                moneyViewModel.fetchTransactions() // Load saved data when the view appears
            }
            .ignoresSafeArea(edges: .bottom)
        }
    }
}

extension HomeView {
    
    private var headerHomeView: some View {
        HStack(alignment: .center) {
            Text("money")
                .font(.system(size: 20, weight: .bold, design: .rounded))
                .foregroundStyle(Color.theme.green)
            
            Spacer()
            
            Text("October 30, 2024")
                .font(.system(size: 12, weight: .semibold, design: .default))
                .foregroundStyle(Color.theme.green)
                .padding(.vertical, 10)
                .padding(.horizontal, 24)
                .background(
                    RoundedRectangle(cornerRadius: 25)
                        .foregroundStyle(Color.theme.green.opacity(0.15))
                )
            
            Spacer()
            
            HStack(alignment: .center, spacing: 24) {
                Image(systemName: "bell")
                    .font(.system(size: 20))
                    .foregroundStyle(Color.theme.accent)
                Image(systemName: "plus")
                    .font(.system(size: 20))
                    .foregroundStyle(Color.theme.accent)
            }
        }
        .padding(.top, 6)
    }
    
    private var spendingTrackerView: some View {
        VStack {
            VStack(spacing: 8) {
                HStack {
                    CircleButtonView(iconName: "questionmark.circle")
                    Spacer()
                    Text("Spending Tracker")
                        .font(.system(size: 16, weight: .semibold, design: .default))
                        .foregroundStyle(Color.theme.accent)
                    Spacer()
                    CircleButtonView(iconName: "ellipsis.circle")
                }
                
                HStack(alignment: .center) {
                    let balance = moneyViewModel.dailyBalance
                    Text("\(String(format: "$ %.2f", balance.amount))")
                        .font(.system(size: 32, weight: .semibold, design: .rounded))
                        .foregroundStyle(balance.isPositive ? Color.theme.green : Color.theme.red)
                }
                .padding(.bottom, 16)
            }
            
            HStack(spacing: 16) {
                VStack(alignment: .leading, spacing: 4) {
                    VStack(alignment: .leading, spacing: 4) {
                        Group {
                            Text("$ \(moneyViewModel.earnedToday, specifier: "%.2f")")
                                .font(.system(size: 18, weight: .medium, design: .default))
                                .foregroundColor(Color.theme.white) +
                            Text("/$ 0")
                                .font(.system(size: 13, weight: .medium, design: .default))
                                .foregroundColor(Color.theme.white.opacity(0.85))
                        }
                        Text("Earned Today")
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
                        Text("$ \(moneyViewModel.spentToday, specifier: "%.2f")")
                            .font(.system(size: 18, weight: .medium, design: .default))
                            .foregroundColor(Color.theme.white)
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
                .foregroundStyle(Color.theme.white)
                .shadow(color: Color.black.opacity(0.07), radius: 0, x: 0, y: 0)
                .shadow(color: Color.black.opacity(0.15), radius: 8, x: 0, y: 2)
        )
    }
    
    private var spendingMonthlySectionView: some View {
        VStack(spacing: 12) {
            HStack {
                Text("Spending in \(moneyViewModel.selectedMonth)")
                    .font(.system(size: 16, weight: .semibold, design: .default))
                    .foregroundStyle(Color.theme.accent)
                
                Spacer()
                
                NavigationLink(destination: ExpenseTransactionsView()) {
                    CircleButtonView(iconName: "chevron.right.circle")
                }
            }
            
            VStack(spacing: 16) {
                HStack(spacing: 16) {
                    SpendingCategoryCardView(
                        categoryName: "Food",
                        type: .expense,
                        gradient: LinearGradient(
                            colors: [Color.theme.food.opacity(0.5), Color.theme.food],
                            startPoint: .bottomLeading,
                            endPoint: .topTrailing
                        )
                    )
                    
                    SpendingCategoryCardView(
                        categoryName: "Entertainment",
                        type: .expense,
                        gradient: LinearGradient(
                            colors: [Color.theme.entertainment.opacity(0.5), Color.theme.entertainment],
                            startPoint: .bottomLeading,
                            endPoint: .topTrailing
                        )
                    )
                }
                
                HStack(spacing: 16) {
                    SpendingCategoryCardView(
                        categoryName: "Shopping",
                        type: .expense,
                        gradient: LinearGradient(
                            colors: [Color.theme.food.opacity(0.5), Color.theme.food],
                            startPoint: .bottomLeading,
                            endPoint: .topTrailing
                        )
                    )
                    
                    SpendingCategoryCardView(
                        categoryName: "Subscriptions",
                        type: .expense,
                        gradient: LinearGradient(
                            colors: [Color.theme.entertainment.opacity(0.5), Color.theme.entertainment],
                            startPoint: .bottomLeading,
                            endPoint: .topTrailing
                        )
                    )
                }
                
                HStack(spacing: 16) {
                    SpendingCategoryCardView(
                        categoryName: "Transport",
                        type: .expense,
                        gradient: LinearGradient(
                            colors: [Color.theme.shopping.opacity(0.5), Color.theme.shopping],
                            startPoint: .bottomLeading,
                            endPoint: .topTrailing
                        )
                    )
                    
                    SpendingCategoryCardView(
                        categoryName: "Other",
                        type: .expense,
                        gradient: LinearGradient(
                            colors: [Color.theme.transport.opacity(0.5), Color.theme.transport],
                            startPoint: .bottomLeading,
                            endPoint: .topTrailing
                        )
                    )
                }
            }
        }
    }
    
    private var incomeMonthlyView: some View {
        VStack(alignment: .center, spacing: 12) {
            HStack {
                Text("Income in October")
                    .font(.system(size: 16, weight: .semibold, design: .default))
                    .foregroundStyle(Color.theme.accent)
                
                Spacer()
                
                NavigationLink(destination: IncomeTransactionsView()) {
                    TextButtonView(text: "View all")
                }
            }
            
            if !moneyViewModel.groupedIncomeRecords.isEmpty {
                VStack(spacing: 0) {
                    ForEach(Array(moneyViewModel.groupedIncomeRecords.prefix(3).enumerated()), id: \.element.categoryName) { index, record in
                        IncomeHomeListItemView(
                            iconName: record.categoryIcon,
                            title: record.categoryName,
                            incomeAmount: "+ $ \(String(format: "%.2f", record.totalAmount))"
                        )
                        
                        if index != moneyViewModel.groupedIncomeRecords.prefix(3).count - 1 {
                            Divider()
                                .padding(.vertical, 10)
                                .padding(.horizontal, 16)
                        }
                    }
                }
                .padding(.vertical, 16)
                .background(
                    RoundedRectangle(cornerRadius: 14)
                        .foregroundStyle(Color.theme.white)
                        .shadow(color: Color.black.opacity(0.1), radius: 1.5, x: 0, y: 0)
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
                    
                    RoundedButtonTextView(text: "Add income")
                }
                .padding(16)
                .background(
                    RoundedRectangle(cornerRadius: 14)
                        .foregroundStyle(Color.theme.white)
                        .shadow(color: Color.black.opacity(0.1), radius: 1.5, x: 0, y: 0)
                )
            }
        }
    }
    
}


#Preview {
    HomeView()
        .environmentObject(MoneyViewModel())
}
