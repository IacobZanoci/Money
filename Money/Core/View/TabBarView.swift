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
    @EnvironmentObject var currencySettingsViewModel: CurrencySettingsViewModel
    @EnvironmentObject var themeSettingsViewModel: ThemeSettingViewModel
    
    @State private var isShowingAddRecordSheet = false
    @State private var selectedRecordType: RecordType = .expense
    
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
                        .frame(height: 0.2)
                        .foregroundColor(Color.theme.accent.opacity(0.05))
                    
                    HStack {
                        Spacer()
                        TabBarItemView(viewRouter: viewRouter,
                                       assignedWindow: .home,
                                       width: geometry.size.width / 5,
                                       height: geometry.size.height / 34,
                                       systemIconName: "square.text.square.fill")
                        Spacer(minLength: geometry.size.width / 7)
                        ZStack {
                            Image(systemName: "plus.circle.fill")
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .frame(width: geometry.size.width / 8.5 - 8,
                                       height: geometry.size.height / 9 - 10)
                                .foregroundStyle(Color.theme.accent.opacity(0.95))
                        }
                        .onTapGesture {
                            HapticManager.instance.impact(style: .medium)
                            selectedRecordType = .expense
                            isShowingAddRecordSheet.toggle()
                        }
                        .sheet(isPresented: $isShowingAddRecordSheet) {
                            AddRecordView(selectedRecordType: $selectedRecordType)
                                .environmentObject(moneyViewModel)
                        }
                        .offset(y: -geometry.size.height / 8 / 8)
                        Spacer(minLength: geometry.size.width / 7)
                        TabBarItemView(viewRouter: viewRouter,
                                       assignedWindow: .settings,
                                       width: geometry.size.width / 5,
                                       height: geometry.size.height / 34,
                                       systemIconName: "square.grid.2x2.fill"
                        )
                        Spacer()
                    }
                    .frame(width: geometry.size.width,
                           height: geometry.size.height / 10)
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
        .environmentObject(CurrencySettingsViewModel())
        .environmentObject(ThemeSettingViewModel())
}
