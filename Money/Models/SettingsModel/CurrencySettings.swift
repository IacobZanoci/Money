//
//  CurrencySettings.swift
//  Money
//
//  Created by Iacob Zanoci on 15/01/2025.
//

import Foundation

class CurrencySettings: ObservableObject {
    @Published var selectedCurrency: String {
        didSet {
            UserDefaults.standard.set(selectedCurrency, forKey: "selectedCurrency")
        }
    }
    
    init() {
        // Load the saved currency, default is "$"
        self.selectedCurrency = UserDefaults.standard.string(forKey: "selectedCurrency") ?? "$"
    }
}
