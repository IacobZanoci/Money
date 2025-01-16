//
//  MoneyApp.swift
//  Money
//
//  Created by Iacob Zanoci on 27/10/2024.
//

import SwiftUI

@main
struct MoneyApp: App {
    @StateObject private var currencySettings = CurrencySettings()
    @StateObject private var moneyViewModel = MoneyViewModel()
    
    var body: some Scene {
        WindowGroup {
            TabBarView(viewRouter: ViewRouter())
                .environmentObject(moneyViewModel)
                .environmentObject(currencySettings)
        }
    }
}
