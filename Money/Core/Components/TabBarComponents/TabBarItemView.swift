//
//  TabBarItemView.swift
//  Money
//
//  Created by Iacob Zanoci on 01/11/2024.
//

import SwiftUI

struct TabBarItemView: View {
    @StateObject var viewRouter: ViewRouter
    
    let assignedWindow: Windows
    let width, height: CGFloat
    let systemIconName: String
    
    var body: some View {
        VStack {
            Image(systemName: systemIconName)
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: width, height: height)
                .padding(.top, 16)
                .foregroundColor(viewRouter.currentWindow == assignedWindow ? Color.theme.accent.opacity(0.85) : Color.theme.accent.opacity(0.2))
            Spacer()
        }
        .contentShape(Rectangle())
        .onTapGesture {
            viewRouter.currentWindow = assignedWindow
        }
        .foregroundStyle(viewRouter.currentWindow == assignedWindow ? Color.theme.accent : Color.theme.accent.opacity(0.3))
    }
}
