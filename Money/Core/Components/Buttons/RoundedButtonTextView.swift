//
//  RoundedButtonTextView.swift
//  Money
//
//  Created by Iacob Zanoci on 31/10/2024.
//

import SwiftUI

struct RoundedButtonTextView: View {
    
    let text: String
    
    var body: some View {
        Text("Set recurring")
            .font(.system(size: 12, weight: .medium, design: .default))
            .foregroundStyle(Color.theme.white)
            .padding(.horizontal, 14)
            .padding(.vertical, 10)
            .background(
                RoundedRectangle(cornerRadius: 8)
                    .foregroundStyle(Color.theme.green)
            )
    }
}

#Preview {
    RoundedButtonTextView(text: "Set recurring")
}
