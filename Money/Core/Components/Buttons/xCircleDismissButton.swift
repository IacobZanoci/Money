//
//  xCircleDismissButton.swift
//  Money
//
//  Created by Iacob Zanoci on 20/01/2025.
//

import SwiftUI

struct xCircleDismissButton: View {
    @Environment(\.presentationMode) private var presentationMode
    
    var body: some View {
        Button(action: {
            presentationMode.wrappedValue.dismiss()
        }) {
            Image(systemName: "x.circle.fill")
                .font(.system(size: 24))
                .foregroundStyle(Color.theme.xCircleDismissButtonPrimaryColor,
                                 Color.theme.xCircleDismissButtonAccentColor)
        }
    }
}

#Preview {
    xCircleDismissButton()
}
