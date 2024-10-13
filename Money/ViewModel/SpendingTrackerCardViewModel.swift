//
//  SpendingTrackerCardViewModel.swift
//  Money
//
//  Created by Iacob Zanoci on 12/10/2024.
//

import Foundation

class SpendingTrackerCardViewModel : ObservableObject {
    
    @Published var spending: SpendingTrackerCard
    
    init(spending: SpendingTrackerCard) {
        self.spending = spending
    }
}
