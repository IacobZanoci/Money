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
    let white = Color("WhiteThemeColor") //should elimine in all code and delete
    let red = Color("RedThemeColor")
    
    let cardColor = Color("CardColor")
    
    // MARK: HomeView
    let whiteComponent = Color("WhiteComponentColor")
    
    //spendingMonthlySectionView
    let groceries = Color("groceriesCategoryColor")
    let entertainment = Color("entertainmentCategoryColor")
    let shopping = Color("shoppingCategoryColor")
    let subscription = Color("subscriptionCategoryColor")
    let transport = Color("transportCategoryColor")
    let utilities = Color("utilitiesCategoryColor")
    let gift = Color("gitCategoryColor")
    let other = Color("otherCategoryColor")
    
    //incomeMonthlyView
    let imageBackground = Color("imageBackgroundColor")
    
    //Buttons Colors
    let textChevronButton = Color("textChevronButtonColor")
    
    
    // SettingsView Buttons Images
    let appearance = Color("settingsButtonAppearanceColor")
    let currency = Color("settingsButtonCurrencyColor")
    let tip = Color("settingsButtonTipColor")
    let bug = Color("settingsButtonBugColor")
    let featureRequest = Color("settingsButtonFeatureRequestColor")
    let rateAppStore = Color("settingsButtonRateAppStoreColor")
    let xTwitter = Color("settingsButtonXTwitterColor")
}
