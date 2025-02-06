//
//  RecordType.swift
//  Money
//
//  Created by Iacob Zanoci on 19/12/2024.
//

import Foundation

enum RecordType: String, CaseIterable, Identifiable {
    case expense
    case income
    
    var id: String { self.rawValue }
}
