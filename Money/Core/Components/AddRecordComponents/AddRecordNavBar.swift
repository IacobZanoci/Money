//
//  AddRecordNavBar.swift
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
        VStack(spacing: 0) {
            HStack {
                Button(action: action) {
                    Image(systemName: icon)
                        .resizable()
                        .scaledToFit()
                        .frame(width: 16, height: 16)
                        .foregroundColor(iconColor)
                }

                Spacer()

                Text(title)
                    .font(.system(size: 16, weight: .medium, design: .default))
                    .foregroundStyle(titleColor)

                Spacer()
            }
            .padding(.vertical, 14)
            .padding(.horizontal)
            .background(Color.theme.background)

            Divider()
                .background(Color.theme.accent).opacity(0.3)
        }
    }
}

#Preview {
    CustomNavBar(
        title: "Add Record",
        icon: "xmark",
        iconColor: Color.theme.red,
        titleColor: Color.theme.accent
    ) {
        print("Dismiss button pressed")
    }
}
