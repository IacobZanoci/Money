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
        Text(text)
            .font(.system(size: 12.5, weight: .medium, design: .default))
            .foregroundStyle(Color.theme.accent)
    }
}

#Preview {
    TextButtonView(text: "View all")
}
