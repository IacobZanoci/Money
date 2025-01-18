//
//  Theme.swift
//  Money
//
//  Created by Iacob Zanoci on 18/01/2025.
//

import Foundation
import SwiftUI

enum Theme: String, CaseIterable, Identifiable {
    case system
    case light
    case dark

    var id: String { rawValue }

    var displayThemeName: String {
        switch self {
        case .system: return "System"
        case .light: return "Light"
        case .dark: return "Dark"
        }
    }
    
    var iconName: String {
        switch self {
        case .system: return "square.righthalf.filled"
        case .light: return "sun.max.fill"
        case .dark: return "moon.fill"
        }
    }
    
    var iconColor: Color {
        switch self {
        case .system: return Color.theme.systemAppearanceImageColor
        case .light: return Color.theme.lightAppearanceImageColor
        case .dark: return Color.theme.darkAppearanceImageColor
        }
    }
}
