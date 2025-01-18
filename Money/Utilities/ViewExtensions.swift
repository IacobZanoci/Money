//
//  ViewExtensions.swift
//  Money
//
//  Created by Iacob Zanoci on 18/01/2025.
//

import SwiftUI

extension View {
    func dismissAfterSelection(seconds: Double, presentationMode: Binding<PresentationMode>, isSelected: Bool) -> some View {
        self.onChange(of: isSelected) { selected in
            if selected {
                DispatchQueue.main.asyncAfter(deadline: .now() + seconds) {
                    presentationMode.wrappedValue.dismiss()
                }
            }
        }
    }
}
