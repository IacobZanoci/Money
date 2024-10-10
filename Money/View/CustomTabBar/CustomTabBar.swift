//
//  CustomTabBar.swift
//  Money
//
//  Created by Iacob Zanoci on 09/10/2024.
//

import SwiftUI

enum Tabs: Int {
    case home = 0
    case notes = 1
    case history = 2
    case settings = 3
}

struct CustomTabBar: View {
    
    @Binding var selectedTab: Tabs
    
    var body: some View {
        
        HStack (alignment: .center) {
            Button {
                selectedTab = .home
            } label: {
                
                TabBarButton(imageName: "house.fill", isActive: selectedTab == .home)
            }
            
            Button {
                selectedTab = .notes
            } label: {
                
                TabBarButton(imageName: "note.text", isActive: selectedTab == .notes)
            }
            
            
            Button {
                //Function to create new expense
            } label: {
                
                TabBarAddButton(imageName: "plus.app.fill")
            }
            
            Button {
                selectedTab = .history
            } label: {
                
                TabBarButton(imageName: "text.magnifyingglass", isActive: selectedTab == .history)
            }
            
            Button {
                selectedTab = .settings
            } label: {
                
                TabBarButton(imageName: "slider.horizontal.3", isActive: selectedTab == .settings)
            }

        }
        .frame(height: 50)
    }
}

#Preview {
    CustomTabBar(selectedTab: .constant(.home))
}
