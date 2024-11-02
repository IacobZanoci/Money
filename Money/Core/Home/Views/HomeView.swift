//
//  HomeView.swift
//  Money
//
//  Created by Iacob Zanoci on 29/10/2024.
//

import SwiftUI

struct HomeView: View {
    
    var body: some View {
        ZStack {
            Color.theme.background.ignoresSafeArea()
            
            VStack(spacing: 10) {
                headerHomeView
                    .padding(.horizontal)
                
                ScrollView {
                    VStack(spacing: 30) {
                        spendingTrackerView
                        spendingMonthlySectionView
                        recurringExpensesView
                        incomeMonthlyView
                    }
                    .padding()
                }
                .scrollIndicators(.hidden)
            }
        }
        .ignoresSafeArea(edges: .bottom)
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
                    Text("$ 0")
                        .font(.system(size: 32, weight: .semibold, design: .rounded))
                        .foregroundStyle(Color.theme.green)
                }
                .padding(.bottom, 16)
            }
            
            HStack(spacing: 16) {
                VStack(alignment: .leading, spacing: 4) {
                    VStack(alignment: .leading, spacing: 4) {
                        Group {
                            Text("$ 0")
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
                        Text("$ 0")
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
                Text("Spending in October")
                    .font(.system(size: 16, weight: .semibold, design: .default))
                    .foregroundStyle(Color.theme.accent)
                
                Spacer()
                
                CircleButtonView(iconName: "chevron.right.circle")
            }
            
            VStack( spacing: 16) {
                HStack(spacing: 16) {
                    SpendingCategoryCardView(
                        cardImage: "fork.knife",
                        cardTitle: "Food",
                        cardSpendingAmount: "$ 0",
                        gradient: LinearGradient(
                            colors: [Color.theme.food.opacity(0.5), Color.theme.food],
                            startPoint: .bottomLeading,
                            endPoint: .topTrailing
                        )
                    )
                    SpendingCategoryCardView(
                        cardImage: "figure",
                        cardTitle: "Entertainment",
                        cardSpendingAmount: "$ 0",
                        gradient: LinearGradient(
                            colors: [Color.theme.entertainment.opacity(0.5), Color.theme.entertainment],
                            startPoint: .bottomLeading,
                            endPoint: .topTrailing
                        )
                    )
                }
                
                HStack(spacing: 16) {
                    SpendingCategoryCardView(
                        cardImage: "bag.fill",
                        cardTitle: "Shopping",
                        cardSpendingAmount: "$ 0",
                        gradient: LinearGradient(
                            colors: [Color.theme.shopping.opacity(0.5), Color.theme.shopping],
                            startPoint: .bottomLeading,
                            endPoint: .topTrailing
                        )
                    )
                    SpendingCategoryCardView(
                        cardImage: "creditcard.fill",
                        cardTitle: "Subscription",
                        cardSpendingAmount: "$ 0",
                        gradient: LinearGradient(
                            colors: [Color.theme.subscription.opacity(0.5), Color.theme.subscription],
                            startPoint: .bottomLeading,
                            endPoint: .topTrailing
                        )
                    )
                }
                
                HStack(spacing: 16) {
                    SpendingCategoryCardView(
                        cardImage: "car.fill",
                        cardTitle: "Transport",
                        cardSpendingAmount: "$ 0",
                        gradient: LinearGradient(
                            colors: [Color.theme.transport.opacity(0.5), Color.theme.transport],
                            startPoint: .bottomLeading,
                            endPoint: .topTrailing
                        )
                    )
                    SpendingCategoryCardView(
                        cardImage: "questionmark.circle.fill",
                        cardTitle: "Other",
                        cardSpendingAmount: "$ 0",
                        gradient: LinearGradient(
                            colors: [Color.theme.other.opacity(0.5), Color.theme.other],
                            startPoint: .bottomLeading,
                            endPoint: .topTrailing
                        )
                    )
                }
            }
        }
    }
    
    private var recurringExpensesView: some View {
        VStack(alignment: .center, spacing: 12) {
            HStack {
                Text("Recurring")
                    .font(.system(size: 16, weight: .semibold, design: .default))
                    .foregroundStyle(Color.theme.accent)
                
                Spacer()
                
                TextButtonView(text: "View all")
            }
            
            VStack(spacing: 20) {
                Image(systemName: "dollarsign.arrow.circlepath")
                    .resizable()
                    .scaledToFit()
                    .foregroundStyle(Color.theme.white)
                    .frame(width: 50)
                    .padding(12)
                    .padding(.leading, -2)
                    .background(
                        Circle()
                            .fill(
                                RadialGradient(gradient: Gradient(colors: [Color.theme.green.opacity(0.55), Color.theme.green.opacity(1)]), center: .center, startRadius: 0, endRadius: 50)
                            )
                    )
                
                Text("Stay organized by setting up recurring payments, so you never miss tracking essential expenses in your budget.")
                    .font(.system(size: 12, weight: .regular, design: .rounded))
                    .foregroundStyle(Color.theme.accent.opacity(0.8))
                    .multilineTextAlignment(.center)
                    .lineSpacing(6)
                
                RoundedButtonTextView(text: "Set recurring")
            }
            .padding(16)
            .frame(maxWidth: .infinity)
            .background(
                RoundedRectangle(cornerRadius: 14)
                    .foregroundStyle(Color.theme.white)
            )
            .shadow(color: Color.black.opacity(0.1), radius: 1.5, x: 0, y: 0)
        }
    }
    
    private var incomeMonthlyView: some View {
        VStack(alignment: .center, spacing: 12) {
            HStack {
                Text("Income in October")
                    .font(.system(size: 16, weight: .semibold, design: .default))
                    .foregroundStyle(Color.theme.accent)
                
                Spacer()
                
                TextButtonView(text: "View all")
            }
            
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
            .frame(maxWidth: .infinity)
            .background(
                RoundedRectangle(cornerRadius: 14)
                    .foregroundStyle(Color.theme.white)
            )
            .shadow(color: Color.black.opacity(0.1), radius: 1.5, x: 0, y: 0)
        }
    }
    
}

#Preview {
    HomeView()
}
