//
//  Money+CoreDataProperties.swift
//  Money
//
//  Created by Iacob Zanoci on 11/12/2024.
//
//

import Foundation
import CoreData


extension Money {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Money> {
        return NSFetchRequest<Money>(entityName: "Money")
    }

    @NSManaged public var spentMoney: Float
    @NSManaged public var earnedMoney: Float

}

extension Money : Identifiable {

}
