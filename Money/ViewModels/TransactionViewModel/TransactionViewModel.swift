//
//  TransactionViewModel.swift
//  Money
//
//  Created by Iacob Zanoci on 15/01/2025.
//

import Foundation
import SwiftUI

class TransactionViewModel: ObservableObject {
    
    //MARK: Published functions
    @Published var slideIn: Bool = false
    
    //MARK: Animations
    func triggerSlideIn() {
        withAnimation(.easeIn(duration: 0.3)) {
            slideIn = true
        }
    }
}
