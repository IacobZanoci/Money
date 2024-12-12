//
//  MoneyApp.swift
//  Money
//
//  Created by Iacob Zanoci on 27/10/2024.
//

import SwiftUI

@main
struct MoneyApp: App {
    @StateObject private var moneyViewModel = MoneyViewModel()
    
    var body: some Scene {
        WindowGroup {
            ContentView(viewRouter: ViewRouter())
                .environmentObject(moneyViewModel) // Inject moneyViewModel to the root view
        }
    }
}
