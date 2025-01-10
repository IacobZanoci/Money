//
//  TabBarView.swift
//  Money
//
//  Created by Iacob Zanoci on 27/10/2024.
//

import SwiftUI

struct TabBarView: View {
    @StateObject var viewRouter: ViewRouter
    @EnvironmentObject var moneyViewModel: MoneyViewModel
    
    @State private var isShowingAddRecordSheet = false
    
    var body: some View {
        GeometryReader { geometry in
            VStack(spacing: 0) {
                switch viewRouter.currentWindow {
                case .home:
                    HomeView()
                        .environmentObject(moneyViewModel)
                case .settings:
                    SettingsView()
                        .environmentObject(moneyViewModel)
                }
                
                VStack(spacing: 0) {
                    Rectangle()
                        .frame(height: 0.5)
                        .foregroundColor(Color.theme.accent.opacity(0.15))
                    
                    HStack {
                        Spacer()
                        TabBarItemView(viewRouter: viewRouter, assignedWindow: .home, width: geometry.size.width / 5, height: geometry.size.height / 36, systemIconName: "house.fill", tabName: "Home")
                        Spacer(minLength: geometry.size.width / 7)
                        ZStack {
                            Image(systemName: "plus.circle.fill")
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .frame(width: geometry.size.width / 8 - 6, height: geometry.size.width / 8 - 6)
                                .foregroundStyle(Color.theme.accent.opacity(0.5))
                        }
                        .onTapGesture {
                            isShowingAddRecordSheet.toggle()
                        }
                        .sheet(isPresented: $isShowingAddRecordSheet) {
                            AddRecordView()
                                .environmentObject(moneyViewModel)
                        }
                        .offset(y: -geometry.size.height / 8 / 8)
                        Spacer(minLength: geometry.size.width / 7)
                        TabBarItemView(viewRouter: viewRouter,
                                       assignedWindow: .settings,
                                       width: geometry.size.width / 5,
                                       height: geometry.size.height / 36,
                                       systemIconName: "gear",
                                       tabName: "Settings"
                        )
                        Spacer()
                    }
                    .frame(width: geometry.size.width, height: geometry.size.height / 10)
                    .background(Color.theme.tabBarBackground)
                }
            }
            .ignoresSafeArea(edges: .bottom)
        }
    }
}

#Preview {
    TabBarView(viewRouter: ViewRouter())
        .environmentObject(MoneyViewModel())
}
