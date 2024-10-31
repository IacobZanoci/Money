//
//  CircleButtonView.swift
//  Money
//
//  Created by Iacob Zanoci on 31/10/2024.
//

import SwiftUI

struct CircleButtonView: View {
    
    let iconName: String
    
    var body: some View {
        Image(systemName: iconName)
            .font(.system(size: 20))
            .foregroundStyle(Color.theme.accent.opacity(0.75))
    }
}

#Preview {
    CircleButtonView(iconName: "chevron.right.circle")
}
