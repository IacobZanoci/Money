//
//  AppearanceSettingView.swift
//  Money
//
//  Created by Iacob Zanoci on 17/01/2025.
//

import SwiftUI

struct AppearanceSettingView: View {
    @EnvironmentObject var themeViewModel: ThemeSettingViewModel
    
    var body: some View {
        NavigationStack {
            List {
                Section {
                    ForEach(Theme.allCases) { theme in
                        HStack(spacing: 10) {
                            HStack {
                                Image(systemName: theme.iconName)
                                    .font(.system(size: 22))
                                    .foregroundStyle(theme.iconColor)
                            }
                            .frame(maxWidth: 26, alignment: .center)
                            HStack {
                                Text(theme.displayThemeName)
                                    .font(.system(size: 13.5, weight: .medium, design: .default))
                                    .foregroundStyle(Color.theme.accent)
                            }
                            Spacer()
                            if themeViewModel.selectedTheme == theme {
                                Image(systemName: "checkmark")
                                    .font(.system(size: 12.5))
                                    .foregroundStyle(Color.theme.accent.opacity(0.7))
                            }
                        }
                        .contentShape(Rectangle())
                        .onTapGesture {
                            themeViewModel.selectedTheme = theme
                        }
                        .listRowBackground(Color.theme.appearanceListBackground)
                        .listRowSeparatorTint(Color.theme.accent.opacity(0.25))
                    }
                } header: {
                    Spacer(minLength: 0)
                        .listRowInsets(EdgeInsets())
                } footer : {
                    Text("Restart the app for change to take effect.")
                        .font(.system(size: 11.5, weight: .medium, design: .default))
                        .foregroundColor(Color.theme.accent.opacity(0.5))
                        .padding(.top, 8)
                }
            }
            .environment(\.defaultMinListHeaderHeight, 16)
            .background(Color.theme.background)
            .scrollContentBackground(.hidden)
            .navigationTitle("Appearance")
            .navigationBarTitleDisplayMode(.inline)
        }
    }
}

#Preview {
    AppearanceSettingView()
        .environmentObject(ThemeSettingViewModel())
}
