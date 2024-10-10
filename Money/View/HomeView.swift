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
                    VStack (alignment: .center, spacing: 6) {
                        Text("You can spend")
                            .font(.system(size: 12, weight: .medium, design: .default))
                            .foregroundStyle(Color("primary-text"))
                        Text("$ 61.32")
                            .font(.system(size: 28, weight: .semibold, design: .rounded))
                            .foregroundStyle(Color("greenColorText"))
                    }
                    
                    HStack {
                        HStack (spacing: 7) {
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
                                Text("$ 63.32")
                                    .font(.system(size: 14, weight: .medium, design: .default))
                                    .foregroundStyle(Color("whiteColorText"))
                                + Text("/$ 77.2(per day)")
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
                        HStack (spacing: 7) {
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
                            Text("$ 3.49")
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
                Spacer()
            }
            .padding()
        }
    }
}

#Preview {
    HomeView()
}
