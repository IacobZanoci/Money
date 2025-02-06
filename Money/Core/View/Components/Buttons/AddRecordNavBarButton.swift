//
//  AddRecordNavBarButton.swift
//  Money
//
//  Created by Iacob Zanoci on 04/11/2024.
//

import SwiftUI

struct AddRecordNavBarButton: View {
    let icon: String
    let action: () -> Void
    
    var body: some View {
        Button(action: action) {
            Image(systemName: icon)
                .font(.system(size: 17, weight: .medium))
                .foregroundStyle(Color.theme.red)
        }
    }
}
