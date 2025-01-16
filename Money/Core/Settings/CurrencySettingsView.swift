//
//  CurrencySettingsView.swift
//  Money
//
//  Created by Iacob Zanoci on 15/01/2025.
//

import SwiftUI

struct CurrencySettingsView: View {
    @EnvironmentObject var currencySettings: CurrencySettings
    
    let currencies = ["$", "€", "AED", "£", "₹"]
    
    var body: some View {
        Form {
            Section(header: Text("Currency")) {
                Picker("Select Currency", selection: $currencySettings.selectedCurrency) {
                    ForEach(currencies, id: \.self) { currency in
                        Text(currency)
                            .tag(currency)
                    }
                }
                .pickerStyle(WheelPickerStyle())
            }
        }
        .navigationTitle("Settings")
    }
}

#Preview {
    CurrencySettingsView()
        .environmentObject(CurrencySettings())
}
