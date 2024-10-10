//
//  TabBarAddButton.swift
//  Money
//
//  Created by Iacob Zanoci on 09/10/2024.
//

import SwiftUI

struct TabBarAddButton: View {
    
    var imageName: String
    
    var body: some View {
        GeometryReader { geo in
            
            VStack {
                Image(systemName: imageName)
                    .resizable()
                    .scaledToFit()
                    .frame(width: 22, height: 22)
                    .foregroundColor(Color("createExpenseButton"))
            }
            .frame(width: geo.size.width, height: geo.size.height)
        }
    }
}

#Preview {
    TabBarAddButton(imageName: "plus.app.fill")
}
