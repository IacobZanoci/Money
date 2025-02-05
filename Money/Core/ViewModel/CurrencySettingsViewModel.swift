//
//  CurrencySettingsViewModel.swift
//  Money
//
//  Created by Iacob Zanoci on 15/01/2025.
//

import Foundation

class CurrencySettingsViewModel: ObservableObject {
    
    @Published var selectedCurrency: String {
        didSet {
            UserDefaults.standard.set(selectedCurrency, forKey: "selectedCurrency")
        }
    }
    
    init() {
        // Default: USD
        self.selectedCurrency = UserDefaults.standard.string(forKey: "selectedCurrency") ?? "USD"
    }
}
