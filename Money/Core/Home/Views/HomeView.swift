//
//  HomeView.swift
//  Money
//
//  Created by Iacob Zanoci on 29/10/2024.
//

import SwiftUI

struct HomeView: View {
    
    //@ObservedObject var viewModel: HomeViewModel
    
    var body: some View {
        ZStack {
            Color.theme.background.ignoresSafeArea()
            
            VStack(spacing: 26) {
                headerHomeView
                
                spendingTrackerView
                
                
                Spacer()
            }
            .padding(.horizontal)
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
            
            Text("October 3, 2024")
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
                    Image(systemName: "questionmark.circle")
                        .font(.system(size: 20))
                        .foregroundStyle(Color.theme.accent.opacity(0.5))
                    Spacer()
                    Text("Spending Tracker")
                        .font(.system(size: 16, weight: .semibold, design: .default))
                        .foregroundStyle(Color.theme.accent)
                    Spacer()
                    Image(systemName: "ellipsis.circle")
                        .font(.system(size: 20))
                        .foregroundStyle(Color.theme.accent.opacity(0.5))
                }
                
                HStack(alignment: .center) {
                    Text("$ 61.32")
                        .font(.system(size: 32, weight: .semibold, design: .rounded))
                        .foregroundStyle(Color.theme.green)
                }
                .padding(.bottom, 16)
            }
            
            HStack(spacing: 16) {
                VStack(alignment: .leading, spacing: 4) {
                    VStack(alignment: .leading, spacing: 4) {
                        Group {
                            Text("$ 63.32")
                                .font(.system(size: 18, weight: .medium, design: .default))
                                .foregroundColor(Color.theme.white) +
                            Text("/$ 77.2")
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
                        Text("$ 23.0")
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
    
}

#Preview {
    HomeView()
}
