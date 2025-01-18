//
//  CurrencySettingsView.swift
//  Money
//
//  Created by Iacob Zanoci on 15/01/2025.
//

import SwiftUI

struct CurrencySettingsView: View {
    @EnvironmentObject var currencySettingViewModel: CurrencySettingsViewModel
    @Environment(\.presentationMode) var presentationMode
    
    @State private var isThemeSelected = false
    
    var body: some View {
        NavigationStack {
            List {
                Section {
                    ForEach(CurrencyData.currencies) { currency in
                        HStack(spacing: 10) {
                            HStack {
                                Text(currency.code)
                                    .font(.system(size: 14, weight: .medium, design: .rounded))
                                    .foregroundStyle(Color.theme.accent.opacity(0.7))
                            }
                            .frame(width: 32, alignment: .leading)
                            
                            HStack {
                                Text(currency.name)
                                    .font(.system(size: 13.5, weight: .medium, design: .default))
                                    .foregroundStyle(Color.theme.accent)
                            }
                            Spacer()
                            if currencySettingViewModel.selectedCurrency == currency.code {
                                Image(systemName: "checkmark")
                                    .font(.system(size: 12.5))
                                    .foregroundColor(Color.theme.accent.opacity(0.7))
                            }
                        }
                        .contentShape(Rectangle())
                        .onTapGesture {
                            currencySettingViewModel.selectedCurrency = currency.code
                            isThemeSelected = true
                        }
                        .listRowBackground(Color.theme.currencyListBackground)
                        .listRowSeparatorTint(Color.theme.accent.opacity(0.25))
                    }
                } header: {
                    Spacer(minLength: 0)
                        .listRowInsets(EdgeInsets()) // Removes any default padding
                }
            }
            .environment(\.defaultMinListHeaderHeight, 16)
            .background(Color.theme.background)
            .scrollContentBackground(.hidden)
            .navigationTitle("Currency")
            .navigationBarTitleDisplayMode(.inline)
            .dismissAfterSelection(seconds: 0.4, presentationMode: presentationMode, isSelected: isThemeSelected)
        }
    }
}

#Preview {
    CurrencySettingsView()
        .environmentObject(CurrencySettingsViewModel())
}
