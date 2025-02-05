//
//  BackNavigationCircleButton.swift
//  Money
//
//  Created by Iacob Zanoci on 24/01/2025.
//

import SwiftUI

struct BackNavigationCircleButton: View {
    @Environment(\.presentationMode) private var presentationMode
    
    var body: some View {
        Button(action: {
            presentationMode.wrappedValue.dismiss()
        }) {
            Image(systemName: "chevron.backward.circle.fill")
                .font(.system(size: 20))
                .symbolRenderingMode(.palette)
                .foregroundStyle(Color.theme.accent.opacity(0.35),
                                 Color.theme.accent.opacity(0.08)
                )
        }
    }
}

#Preview {
    BackNavigationCircleButton()
}
