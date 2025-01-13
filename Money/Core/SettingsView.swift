//
//  SettingsView.swift
//  Money
//
//  Created by Iacob Zanoci on 29/10/2024.
//

import SwiftUI

struct SettingsView: View {
    var body: some View {
        NavigationStack {
            ZStack {
                Color.theme.background.ignoresSafeArea()
                
                VStack(spacing: 16) {
                    
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
                            NavigationLink(destination: EmptyView()) {
                                SettingsViewButton(image: "square.righthalf.filled",
                                                   colorName: Color.theme.appearance,
                                                   title: "Appearance",
                                                   type: "System",
                                                   showType: true)
                            }
                            
                            NavigationLink(destination: EmptyView()) {
                                SettingsViewButton(image: "dollarsign.square.fill",
                                                   colorName: Color.theme.currency,
                                                   title: "Currency",
                                                   type: "MDL",
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
                            NavigationLink(destination: EmptyView()) {
                                SettingsViewButton(image: "heart.square.fill",
                                                   colorName: Color.theme.tip,
                                                   title: "Tip Iacob",
                                                   type: "",
                                                   showType: false)
                            }
                            
                            NavigationLink(destination: EmptyView()) {
                                SettingsViewButton(image: "hand.raised.square.fill",
                                                   colorName: Color.theme.bug,
                                                   title: "Report Bug",
                                                   type: "",
                                                   showType: false)
                            }
                            
                            NavigationLink(destination: EmptyView()) {
                                SettingsViewButton(image: "plus.square.fill",
                                                   colorName: Color.theme.featureRequest,
                                                   title: "Feature Request",
                                                   type: "",
                                                   showType: false)
                            }
                            
                            NavigationLink(destination: EmptyView()) {
                                SettingsViewButton(image: "star.square.fill",
                                                   colorName: Color.theme.rateAppStore,
                                                   title: "Rate on App Store",
                                                   type: "",
                                                   showType: false)
                            }
                            
                            NavigationLink(destination: EmptyView()) {
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
                .padding(.horizontal)
            }
        }
    }
}

#Preview {
    SettingsView()
}
