//
//  MoneyViewModel.swift
//  Money
//
//  Created by Iacob Zanoci on 11/12/2024.
//

import SwiftUI
import CoreData

class MoneyViewModel: ObservableObject {
    @Published var spentMoney: Float = 0
    @Published var earnedMoney: Float = 0
    
    private let container: NSPersistentContainer
    
    init(container: NSPersistentContainer = PersistenceController.shared.container) {
        self.container = container
        fetchData()
    }
    
    // This method is responsible for fetching data
    func fetchData() {
        let fetchRequest: NSFetchRequest<Money> = Money.fetchRequest()
        
        do {
            let result = try container.viewContext.fetch(fetchRequest)
            if let moneyData = result.first {
                spentMoney = moneyData.spentMoney
                earnedMoney = moneyData.earnedMoney
            }
        } catch {
            print("Error fetching data: \(error.localizedDescription)")
        }
    }
    
    func addSpentMoney(amount: Float) {
        spentMoney += amount
        saveToCoreData()
    }
    
    func addEarnedMoney(amount: Float) {
        earnedMoney += amount
        saveToCoreData()
    }
    
    private func saveToCoreData() {
        let fetchRequest: NSFetchRequest<Money> = Money.fetchRequest()
        
        do {
            let result = try container.viewContext.fetch(fetchRequest)
            let moneyData = result.first ?? Money(context: container.viewContext)
            moneyData.spentMoney = spentMoney
            moneyData.earnedMoney = earnedMoney
            
            try container.viewContext.save()
        } catch {
            print("Error saving data: \(error.localizedDescription)")
        }
    }
}
