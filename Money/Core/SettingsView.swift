//
//  SettingsView.swift
//  Money
//
//  Created by Iacob Zanoci on 29/10/2024.
//

import SwiftUI

struct SettingsView: View {
    
    @EnvironmentObject var currencySettingsViewModel: CurrencySettingsViewModel
    @EnvironmentObject var themeViewModel: ThemeSettingViewModel
    
    @StateObject private var emailRequestViewModel = EmailRequestViewModel()
    @State private var showMailErrorAlert = false
    
    var body: some View {
        NavigationStack {
            ZStack {
                Color.theme.background.ignoresSafeArea()
                
                VStack(spacing: 20) {
                    
                    VStack(alignment: .leading) {
                        Text("Settings")
                            .font(.system(size: 26, weight: .semibold, design: .rounded))
                            .foregroundStyle(Color.theme.accent)
                            .frame(maxWidth: .infinity, alignment: .leading)
                    }
                    
                    VStack(spacing: 6) {
                        VStack {
                            Text("GENERAL")
                                .font(.system(size: 12, weight: .medium, design: .default))
                                .foregroundStyle(Color.theme.accent.opacity(0.7))
                                .frame(maxWidth: .infinity, alignment: .leading)
                        }
                        
                        VStack(spacing: 10) {
                            NavigationLink(destination: AppearanceSettingView()) {
                                SettingsViewButton(image: "square.righthalf.filled",
                                                   colorName: Color.theme.appearance,
                                                   title: "Appearance",
                                                   type: themeViewModel.selectedTheme.displayThemeName,
                                                   showType: true)
                            }
                            
                            NavigationLink(destination: CurrencySettingsView()) {
                                SettingsViewButton(image: "dollarsign.square.fill",
                                                   colorName: Color.theme.currency,
                                                   title: "Currency",
                                                   type: currencySettingsViewModel.selectedCurrency,
                                                   showType: true)
                            }
                        }
                    }
                    
                    VStack(spacing: 6) {
                        VStack {
                            Text("OTHERS")
                                .font(.system(size: 12, weight: .medium, design: .default))
                                .foregroundStyle(Color.theme.accent.opacity(0.7))
                                .frame(maxWidth: .infinity, alignment: .leading)
                        }
                        
                        VStack(spacing: 10) {
                            
                            Button(action: {
                                if emailRequestViewModel.canSendMail {
                                    emailRequestViewModel.openMailApp(for: .reportBug)
                                } else {
                                    showMailErrorAlert = true
                                }
                            }) {
                                SettingsViewButton(image: "hand.raised.square.fill",
                                                   colorName: Color.theme.bug,
                                                   title: "Report Bug",
                                                   type: "",
                                                   showType: false)
                            }
                            .alert(isPresented: $showMailErrorAlert) {
                                Alert(
                                    title: Text("Mail Not Available"),
                                    message: Text("Your device is not configured to send emails."),
                                    dismissButton: .default(Text("OK"))
                                )
                            }
                            
                            Button(action: {
                                if emailRequestViewModel.canSendMail {
                                    emailRequestViewModel.openMailApp(for: .featureRequest)
                                } else {
                                    showMailErrorAlert = true
                                }
                            }) {
                                SettingsViewButton(image: "plus.square.fill",
                                                   colorName: Color.theme.featureRequest,
                                                   title: "Feature Request",
                                                   type: "",
                                                   showType: false)
                            }
                            .alert(isPresented: $showMailErrorAlert) {
                                Alert(
                                    title: Text("Mail Not Available"),
                                    message: Text("Your device is not configured to send emails."),
                                    dismissButton: .default(Text("OK"))
                                )
                            }
                            
                            Button(action: {
                                if let appUrl = URL(string: "twitter://user?screen_name=iacobzanoci"),
                                   UIApplication.shared.canOpenURL(appUrl) {
                                    UIApplication.shared.open(appUrl)
                                } else if let webUrl = URL(string: "https://x.com/iacobzanoci") {
                                    UIApplication.shared.open(webUrl)
                                }
                            }) {
                                SettingsViewButton(image: "x.square.fill",
                                                   colorName: Color.theme.xTwitter,
                                                   title: "Follow Iacob on X",
                                                   type: "",
                                                   showType: false)
                            }
                        }
                    }
                    Spacer()
                }
                .padding()
            }
        }
    }
}

#Preview {
    SettingsView()
        .environmentObject(CurrencySettingsViewModel())
        .environmentObject(ThemeSettingViewModel())
}
