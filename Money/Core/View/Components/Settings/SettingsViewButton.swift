//
//  SettingsViewButton.swift
//  Money
//
//  Created by Iacob Zanoci on 05/01/2025.
//

import SwiftUI

struct SettingsViewButton: View {
    
    let image: String
    let colorName: Color
    let title: String
    let type: String
    let showType: Bool
    
    var body: some View {
        HStack {
            HStack(spacing: 7) {
                ZStack {
                    RoundedRectangle(cornerRadius: 3)
                        .frame(width: 22, height: 22)
                        .foregroundStyle(Color.theme.white)
                        .overlay(
                            Image(systemName: image)
                                .font(.system(size: 26))
                                .foregroundStyle(colorName)
                        )
                }
                Text(title)
                    .font(.system(size: 14, weight: .medium, design: .default))
                    .foregroundStyle(Color.theme.accent)
            }
            
            Spacer()
            
            if showType {
                HStack(spacing: 4) {
                    Text(type)
                        .font(.system(size: 13, weight: .medium, design: .default))
                        .foregroundStyle(Color.theme.accent.opacity(0.7))
                    Image(systemName: "chevron.right")
                        .font(.system(size: 12))
                        .foregroundStyle(Color.theme.accent.opacity(0.7))
                }
            } else {
                Image(systemName: "chevron.right")
                    .font(.system(size: 12))
                    .foregroundStyle(Color.theme.accent.opacity(0.7))
            }
        }
        .padding(.horizontal, 12)
        .padding(.vertical, 12)
        .background(
            RoundedRectangle(cornerRadius: 8)
                .fill(Color.theme.whiteComponent)
                .overlay(
                    RoundedRectangle(cornerRadius: 8)
                        .stroke(Color.theme.accent.opacity(0.12), lineWidth: 1.5)
                )
        )
    }
}

#Preview {
    VStack(spacing: 20) {
        SettingsViewButton(
            image: "square.righthalf.filled",
            colorName: Color.theme.appearance,
            title: "Appearance",
            type: "System",
            showType: true
        )
        
        SettingsViewButton(
            image: "square.righthalf.filled",
            colorName: Color.theme.currency,
            title: "Appearance",
            type: "",
            showType: false
        )
    }
    .padding(.horizontal)
}
