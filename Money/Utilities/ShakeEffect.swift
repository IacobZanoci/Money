//
//  ShakeEffect.swift
//  Money
//
//  Created by Iacob Zanoci on 29/01/2025.
//

import SwiftUI

extension View {
    func shake(shakeCount: Int = 6, shakeDistance: CGFloat = 10, duration: Double = 0.5, shakeOffset: Binding<CGFloat>) {
        HapticManager.instance.notification(type: .error)
        
        let animationDuration = duration / Double(shakeCount * 2)
        
        withAnimation(.easeInOut(duration: animationDuration)) {
            shakeOffset.wrappedValue = -shakeDistance
        }
        
        for i in 1..<shakeCount {
            DispatchQueue.main.asyncAfter(deadline: .now() + (animationDuration * Double(i * 2))) {
                withAnimation(.easeInOut(duration: animationDuration)) {
                    shakeOffset.wrappedValue = (i % 2 == 0) ? -shakeDistance : shakeDistance
                }
            }
        }
        
        DispatchQueue.main.asyncAfter(deadline: .now() + duration) {
            withAnimation(.easeInOut(duration: animationDuration)) {
                shakeOffset.wrappedValue = 0
            }
        }
    }
}
