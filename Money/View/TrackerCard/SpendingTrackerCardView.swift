//
//  SpendingTrackerCardView.swift
//  Money
//
//  Created by Iacob Zanoci on 12/10/2024.
//

import SwiftUI

struct SpendingTrackerCardView: View {
    
    @ObservedObject var viewModel: SpendingTrackerCardViewModel
    
    var body: some View {
            VStack {
                VStack(alignment: .center, spacing: 6) {
                    Text("You can spend")
                        .font(.system(size: 12, weight: .medium, design: .default))
                        .foregroundStyle(Color("primary-text"))
                    
                    Text("$ \(viewModel.spending.canSpend, specifier: "%.2f")")
                        .font(.system(size: 28, weight: .semibold, design: .rounded))
                        .foregroundStyle(Color("greenColorText"))
                }

                HStack {
                    HStack(spacing: 7) {
                        Image(systemName: "arrow.up.forward.square")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 18, height: 18)
                            .foregroundStyle(Color("whiteColorBackground"))

                        Text("Earned Today")
                            .font(.system(size: 12, weight: .medium, design: .default))
                            .foregroundStyle(Color("whiteColorText"))
                    }

                    Spacer()

                    HStack {
                        Group {
                            Text("$ \(viewModel.spending.earnedToday, specifier: "%.2f")")
                                .font(.system(size: 14, weight: .medium, design: .default))
                                .foregroundStyle(Color("whiteColorText"))
                            + Text("/$ \(viewModel.spending.dailyEarning, specifier: "%.2f")(per day)")
                                .font(.system(size: 9, weight: .medium, design: .default))
                                .foregroundStyle(Color("whiteColorText").opacity(0.7))
                        }
                    }
                }
                .padding(.vertical, 23)
                .padding(.horizontal, 16)
                .background(
                    RoundedRectangle(cornerRadius: 14)
                        .fill(
                            LinearGradient(
                                gradient: Gradient(colors: [Color("greenColorBackground").opacity(0.8), Color("greenColorBackground")]),
                                startPoint: .topLeading,
                                endPoint: .bottomTrailing
                            )
                        )
                )

                HStack {
                    HStack(spacing: 7) {
                        Image(systemName: "arrow.down.right.square")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 18, height: 18)
                            .foregroundStyle(Color("whiteColorText"))

                        Text("Spent Today")
                            .font(.system(size: 12, weight: .medium, design: .default))
                            .foregroundStyle(Color("whiteColorText"))
                    }

                    Spacer()

                    HStack {
                        Text("$ \(viewModel.spending.spentToday, specifier: "%.2f")")
                            .font(.system(size: 14, weight: .medium, design: .default))
                            .foregroundStyle(Color("whiteColorText"))
                    }
                }
                .padding(.vertical, 23)
                .padding(.horizontal, 16)
                .background(
                    RoundedRectangle(cornerRadius: 14)
                        .fill(
                            LinearGradient(
                                gradient: Gradient(colors: [Color("redColorBackground").opacity(0.8), Color("redColorBackground")]),
                                startPoint: .topLeading,
                                endPoint: .bottomTrailing
                            )
                        )
                )
            }
            .padding()
            .background(
                RoundedRectangle(cornerRadius: 14)
                    .fill(Color("spendingHomeCard"))
                    .shadow(color: .black.opacity(0.1), radius: 3, x: 0, y: 0)
            )
            .padding(.top, 16)
        }
}

#Preview {
    SpendingTrackerCardView(viewModel: SpendingTrackerCardViewModel(spending: SpendingTrackerCard(canSpend: 20.20, earnedToday: 30.30, spentToday: 40.40, dailyEarning: 50.50)))
}
