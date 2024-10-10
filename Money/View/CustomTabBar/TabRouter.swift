//
//  TabRouter.swift
//  Money
//
//  Created by Iacob Zanoci on 09/10/2024.
//

import SwiftUI

struct TabRouter: View {
    
    @Binding var selectedTab: Tabs
    
    var body: some View {
        // Logic to switch views based on the selected tab
        switch selectedTab {
        case .home:
            HomeView()
        case .notes:
            NotesView()
        case .history:
            HistoryView()
        case .settings:
            SettingsView()
        }
    }
}

#Preview {
    TabRouter(selectedTab: .constant(.home))
}
