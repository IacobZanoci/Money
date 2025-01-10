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
    let systemIconName, tabName: String
    
    var body: some View {
        VStack {
            Image(systemName: systemIconName)
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: width, height: height)
                .padding(.top, 10)
                .foregroundColor(viewRouter.currentWindow == assignedWindow ? Color.theme.green : Color.theme.accent.opacity(0.5))
            Text(tabName)
                .font(.system(size: 10, weight: .medium, design: .default))
                .foregroundStyle(viewRouter.currentWindow == assignedWindow ? Color.theme.green : Color.theme.accent.opacity(0.5))
            Spacer()
        }
        .onTapGesture {
            viewRouter.currentWindow = assignedWindow
        }
        .foregroundStyle(viewRouter.currentWindow == assignedWindow ? Color.theme.green : Color.theme.accent.opacity(0.5))
    }
}
