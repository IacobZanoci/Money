//
//  ThemeSettingViewModel.swift
//  Money
//
//  Created by Iacob Zanoci on 17/01/2025.
//

import SwiftUI

class ThemeSettingViewModel: ObservableObject {
    
    private let userDefaultsKey = "selectedTheme"
    
    @Published var selectedTheme: Theme {
        didSet {
            UserDefaults.standard.set(selectedTheme.rawValue, forKey: "selectedTheme")
        }
    }

    init() {
        let savedTheme = UserDefaults.standard.string(forKey: "selectedTheme")
        selectedTheme = Theme(rawValue: savedTheme ?? Theme.system.rawValue) ?? .system
    }
}

