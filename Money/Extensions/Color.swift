//
//  Color.swift
//  Money
//
//  Created by Iacob Zanoci on 29/10/2024.
//

import Foundation
import SwiftUI

extension Color {
     
    static let theme = ColorTheme()
    
}

struct ColorTheme {
    
    // App Colors
    let background = Color("BackgroundColor")
    let accent = Color("AccentColor")
    let green = Color("GreenThemeColor")
    let white = Color("WhiteThemeColor")
    let red = Color("RedThemeColor")
    
    // Spending Category Card (HomeView)
    let food = Color("foodCategoryColor")
    let entertainment = Color("entertainmentCategoryColor")
    let shopping = Color("shoppingCategoryColor")
    let subscription = Color("subscriptionCategoryColor")
    let transport = Color("transportCategoryColor")
    let other = Color("otherCategoryColor")
    
}
