//
//  EmailType.swift
//  Money
//
//  Created by Iacob Zanoci on 19/01/2025.
//

import Foundation

enum EmailType {
    case featureRequest
    case reportBug
    
    var subject: String {
        switch self {
        case .featureRequest:
            return "Feature Request"
        case .reportBug:
            return "Report Bug"
        }
    }
}
