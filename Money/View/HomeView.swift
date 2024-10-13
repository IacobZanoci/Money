//
//  HomeView.swift
//  Money
//
//  Created by Iacob Zanoci on 09/10/2024.
//

import SwiftUI

struct HomeView: View {
    
    @StateObject var viewModel = SpendingTrackerCardViewModel(spending: SpendingTrackerCard(canSpend: 11.11, earnedToday: 22.22, spentToday: 33.33, dailyEarning: 44.44))
    
    var body: some View {
        
        ZStack {
            Color("viewBackgroundGrey").ignoresSafeArea()
            
            VStack {
                HStack {
                    VStack {
                        Image(systemName: "square.and.pencil")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 24, height: 24)
                    }
                    
                    Spacer()
                    
                    VStack {
                        VStack {
                            Text("October 3, 2024")
                                .font(.system(size: 12, weight: .semibold, design: .default))
                                .foregroundStyle(Color("greenColorText"))
                                .padding(.vertical, 6)
                                .padding(.horizontal, 24)
                        }
                        .background(
                            RoundedRectangle(cornerRadius: 25)
                                .foregroundStyle(Color("greenColorBackground").opacity(0.15))
                        )
                    }
                    
                    Spacer()
                    
                    VStack {
                        Image(systemName: "slider.horizontal.3")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 24, height: 24)
                    }
                }
                
                VStack {
                    SpendingTrackerCardView(viewModel: viewModel)
                }
                
                
                VStack {
                    HStack {
                        Text("Spending in October")
                            .font(.system(size: 20, weight: .semibold, design: .default))
                            .foregroundStyle(Color("primary-text"))
                            .padding(.leading, 16)
                        Spacer()
                    }
                }
                .padding(.top, 16)
                
                Spacer()
            }
            .padding()
        }
    }
}

#Preview {
    HomeView()
}
