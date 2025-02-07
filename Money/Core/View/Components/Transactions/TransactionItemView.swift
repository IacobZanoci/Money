//
//  TransactionItemView.swift
//  Money
//
//  Created by Iacob Zanoci on 26/12/2024.
//

import SwiftUI

struct TransactionItemView: View {
    let icon: String
    let title: String
    let time: String
    let amount: String
    let color: Color
    
    var body: some View {
        HStack(alignment: .firstTextBaseline) {
            HStack(spacing: 10) {
                ZStack {
                    Circle()
                        .fill(color)
                        .frame(width: 30, height: 30)
                        .opacity(0.1)
                    
                    Image(systemName: icon)
                        .resizable()
                        .scaledToFit()
                        .foregroundStyle(color)
                        .frame(width: 18, height: 18)
                }
                
                VStack(alignment: .leading) {
                    Text(title)
                        .font(.system(size: 12, weight: .medium, design: .default))
                        .foregroundStyle(Color.theme.accent)
                    Text(time)
                        .font(.system(size: 10, weight: .medium, design: .rounded))
                        .foregroundStyle(Color.theme.accent).opacity(0.5)
                }
            }
            
            Spacer()
            
            VStack {
                Text(amount)
                    .font(.system(size: 12, weight: .semibold, design: .rounded))
                    .foregroundStyle(Color.theme.accent).opacity(0.8)
            }
        }
    }
}


struct TransactionItemView_Previews: PreviewProvider {
    static var previews: some View {
        TransactionItemView(
            icon: "basket.fill",
            title: "Groceries",
            time: "12:30 PM",
            amount: "- $45.99",
            color: Color.theme.red
        )
        .previewLayout(.sizeThatFits)
        .padding()
    }
}
