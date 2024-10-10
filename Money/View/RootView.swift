//
//  RootView.swift
//  Money
//
//  Created by Iacob Zanoci on 09/10/2024.
//

import SwiftUI

struct RootView: View {
    
    @State var selectedTab: Tabs = .home
    
    var body: some View {
        VStack {
            // Use TabRouter to route between views
            TabRouter(selectedTab: $selectedTab)
            
            Spacer()
            
            CustomTabBar(selectedTab: $selectedTab)
        }
    }
}

#Preview {
    RootView()
}
