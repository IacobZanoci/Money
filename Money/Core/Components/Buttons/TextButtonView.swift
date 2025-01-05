//
//  TextButtonView.swift
//  Money
//
//  Created by Iacob Zanoci on 31/10/2024.
//

import SwiftUI

struct TextButtonView: View {
    
    let text: String
    
    var body: some View {
        
        HStack(spacing: 4) {
            Text(text)
                .font(.system(size: 12.5, weight: .medium, design: .default))
                .foregroundStyle(Color.theme.accent)
            Image(systemName: "chevron.right")
                .font(.system(size: 10))
                .foregroundStyle(Color.theme.accent)
        }
        .padding(.horizontal, 12)
        .padding(.vertical, 8)
        .background(
            RoundedRectangle(cornerRadius: 12)
                .foregroundStyle(Color.theme.accent.opacity(0.08))
        )
    }
}

#Preview {
    TextButtonView(text: "View All")
}
