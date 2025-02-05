//
//  xMarkDismissButton.swift
//  Money
//
//  Created by Iacob Zanoci on 21/01/2025.
//

import SwiftUI

struct xMarkDismissButton: View {
    @Environment(\.presentationMode) private var presentationMode
    
    let color: Color
    
    var body: some View {
        Button(action: {
            HapticManager.instance.impact(style: .light)
            
            presentationMode.wrappedValue.dismiss()
        }) {
            Image(systemName: "xmark")
                .font(.system(size: 18))
                .foregroundStyle(color)
        }
    }
}

#Preview {
    xMarkDismissButton(color: Color.theme.red.opacity(0.8))
}
