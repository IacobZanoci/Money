//
//  PreferenceKeys.swift
//  Money
//
//  Created by Iacob Zanoci on 20/01/2025.
//

import Foundation
import SwiftUI

struct InnerHeightPreferenceKey: PreferenceKey {
    static let defaultValue: CGFloat = .zero
    static func reduce(value: inout CGFloat, nextValue: () -> CGFloat) {
        value = nextValue()
    }
}
