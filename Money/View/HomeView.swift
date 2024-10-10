//
//  HomeView.swift
//  Money
//
//  Created by Iacob Zanoci on 09/10/2024.
//

import SwiftUI

struct HomeView: View {
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
                                .foregroundStyle(Color("green"))
                                .padding(.vertical, 6)
                                .padding(.horizontal, 24)
                        }
                        .background(
                            RoundedRectangle(cornerRadius: 25)
                                .foregroundStyle(Color("green").opacity(0.15))
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
                    VStack (alignment: .center, spacing: 6) {
                        Text("You can spend")
                            .font(.system(size: 12, weight: .medium, design: .default))
                            .foregroundStyle(Color("primary-text"))
                        Text("$ 61.32")
                            .font(.system(size: 28, weight: .semibold, design: .rounded))
                            .foregroundStyle(Color("green"))
                    }
                    
                    HStack {
                        HStack (spacing: 7) {
                            Image(systemName: "arrow.up.forward.square")
                                .resizable()
                                .scaledToFit()
                                .frame(width: 18, height: 18)
                                .foregroundStyle(Color("white"))
                            
                            Text("Earned Today")
                                .font(.system(size: 12, weight: .medium, design: .default))
                                .foregroundStyle(Color("white"))
                        }
                        
                        Spacer()
                        
                        HStack {
                            Group {
                                Text("$ 63.32")
                                    .font(.system(size: 14, weight: .medium, design: .default))
                                    .foregroundStyle(Color("white"))
                                + Text("/$ 77.2(per day)")
                                    .font(.system(size: 9, weight: .medium, design: .default))
                                    .foregroundStyle(Color("white").opacity(0.7))
                            }
                        }
                    }
                    .padding(.vertical, 23)
                    .padding(.horizontal, 16)
                    .background(
                        RoundedRectangle(cornerRadius: 14)
                            .fill(
                                LinearGradient(
                                    gradient: Gradient(colors: [Color("green").opacity(0.8), Color("green")]),
                                    startPoint: .topLeading,
                                    endPoint: .bottomTrailing
                                )
                            )
                    )
                    
                    HStack {
                        HStack (spacing: 7) {
                            Image(systemName: "arrow.down.right.square")
                                .resizable()
                                .scaledToFit()
                                .frame(width: 18, height: 18)
                                .foregroundStyle(Color("white"))
                            
                            Text("Spent Today")
                                .font(.system(size: 12, weight: .medium, design: .default))
                                .foregroundStyle(Color("white"))
                        }
                        
                        Spacer()
                        
                        HStack {
                            Text("$ 3.49")
                                .font(.system(size: 14, weight: .medium, design: .default))
                                .foregroundStyle(Color("white"))
                        }
                    }
                    .padding(.vertical, 23)
                    .padding(.horizontal, 16)
                    .background(
                        RoundedRectangle(cornerRadius: 14)
                            .fill(
                                LinearGradient(
                                    gradient: Gradient(colors: [Color("red").opacity(0.8), Color("red")]),
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
                Spacer()
            }
            .padding()
        }
    }
}

#Preview {
    HomeView()
}
