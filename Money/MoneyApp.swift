//
//  MoneyApp.swift
//  Money
//
//  Created by Iacob Zanoci on 27/10/2024.
//

import SwiftUI

@main
struct MoneyApp: App {
    @StateObject private var currencySettingsViewModel = CurrencySettingsViewModel()
    @StateObject private var moneyViewModel = MoneyViewModel()
    @StateObject private var themeViewModel = ThemeSettingViewModel()
    
    @AppStorage("hasSeenOnboarding") private var hasSeenOnboarding: Bool = false
    
    var body: some Scene {
        WindowGroup {
            if hasSeenOnboarding {
                TabBarView(viewRouter: ViewRouter())
                    .environmentObject(moneyViewModel)
                    .environmentObject(currencySettingsViewModel)
                    .environmentObject(themeViewModel)
                    .preferredColorScheme(themeViewModel.selectedTheme == .light ? .light : (themeViewModel.selectedTheme == .dark ? .dark : nil))
            } else {
                OnboardingView()
            }
        }
    }
}
