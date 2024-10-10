//
//  TabBarButton.swift
//  Money
//
//  Created by Iacob Zanoci on 09/10/2024.
//

import SwiftUI

struct TabBarButton: View {
    
    var imageName: String
    var isActive: Bool
    
    var body: some View {
        GeometryReader { geo in
            
            VStack {
                Image(systemName: imageName)
                    .resizable()
                    .scaledToFit()
                    .frame(width: 22, height: 22)
                    .foregroundColor(isActive ? Color("tabBarIconActive") : Color("tabBarIconNotActive"))
            }
            .frame(width: geo.size.width, height: geo.size.height)
        }
    }
}

#Preview {
    TabBarButton(imageName: "house.fill", isActive: true)
}
