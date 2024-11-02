//
//  ViewRouter.swift
//  Money
//
//  Created by Iacob Zanoci on 01/11/2024.
//

import Foundation

class ViewRouter: ObservableObject {
    
    @Published var currentWindow: Windows = .home
    
}

enum Windows {
    case home
    case settings
}
