//
//  CustomNavBar.swift
//  Money
//
//  Created by Iacob Zanoci on 14/12/2024.
//

import SwiftUI

struct CustomNavBar: View {
    let title: String
    let icon: String
    let iconColor: Color
    let titleColor: Color
    let action: () -> Void
    
    var body: some View {
        
        ZStack {
            Button(action: action) {
                Image(systemName: icon)
                    .font(.system(size: 20))
                    .foregroundColor(iconColor.opacity(0.8))
            }
            .frame(maxWidth: .infinity, alignment: .leading)
            
            Text(title)
                .font(.system(size: 16, weight: .medium, design: .default))
                .foregroundStyle(titleColor)
                .frame(maxWidth: .infinity, alignment: .center)
        }
        .padding(.top, 14)
        .padding(.horizontal, 16)
    }
}

#Preview {
    CustomNavBar(
        title: "Categories",
        icon: "arrow.left",
        iconColor: Color.theme.red,
        titleColor: Color.theme.accent
    ) {
        print("Dismiss button pressed")
    }
}
