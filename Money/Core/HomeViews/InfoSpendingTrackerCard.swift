//
//  InfoSpendingTrackerCard.swift
//  Money
//
//  Created by Iacob Zanoci on 20/01/2025.
//

import SwiftUI

struct InfoSpendingTrackerCard: View {
    var body: some View {
        VStack {
            HStack {
                HStack(spacing: 4) {
                    Image(systemName: "info.square.fill")
                        .font(.system(size: 21))
                        .foregroundStyle(Color.theme.accent.opacity(0.75))
                    
                    Text("How does it work?")
                        .font(.system(size: 16, weight: .semibold, design: .default))
                        .foregroundStyle(Color.theme.accent)
                }
                Spacer()
                VStack {
                    xCircleDismissButton()
                }
            }
            
            VStack {
                VStack(spacing: 12) {
                    ZStack {
                        Text("Spending Tracker")
                            .font(.system(size: 16, weight: .semibold, design: .default))
                            .foregroundStyle(Color.theme.accent)
                    }
                    
                    VStack(spacing: 0) {
                        Text("+ Profit / Loss -")
                            .font(.system(size: 26, weight: .semibold, design: .rounded))
                            .foregroundStyle(Color.theme.accent.opacity(0.8))
                        
                        Text("(for actual month)")
                            .font(.system(size: 16, weight: .medium, design: .rounded))
                            .foregroundStyle(Color.theme.accent.opacity(0.4))
                    }
                    .padding(.bottom, 20)
                }
                
                HStack(spacing: 16) {
                    VStack(alignment: .leading, spacing: 4) {
                        VStack(alignment: .leading, spacing: 4) {
                            Text("+ Earnings")
                                .font(.system(size: 18, weight: .medium, design: .rounded))
                                .foregroundStyle(Color.theme.white)
                            
                            Group {
                                Text("for actual ")
                                    .font(.system(size: 12, weight: .medium, design: .default))
                                    .foregroundColor(Color.theme.white) +
                                Text("month")
                                    .font(.system(size: 12, weight: .medium, design: .default))
                                    .foregroundColor(Color.theme.white)
                                    .underline()
                            }
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
                            Text("- Spendings")
                                .font(.system(size: 18, weight: .medium, design: .rounded))
                                .foregroundStyle(Color.theme.white)
                            
                            Group {
                                Text("for actual ")
                                    .font(.system(size: 12, weight: .medium, design: .default))
                                    .foregroundColor(Color.theme.white) +
                                Text("day")
                                    .font(.system(size: 12, weight: .medium, design: .default))
                                    .foregroundColor(Color.theme.white)
                                    .underline()
                            }
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
                    .foregroundStyle(Color.theme.infoSpendingTrackerCardBackground)
                    .shadow(color: Color.black.opacity(0.2), radius: 0, x: 0, y: 0)
                    .shadow(color: Color.black.opacity(0.17), radius: 3, x: 0, y: 1.5)
            )
            .padding(.top, 12)
        }
        .padding()
    }
}

#Preview {
    InfoSpendingTrackerCard()
}
