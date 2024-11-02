//
//  ContentView.swift
//  Money
//
//  Created by Iacob Zanoci on 27/10/2024.
//

import SwiftUI

struct ContentView: View {
    
    @StateObject var viewRouter: ViewRouter
    
    var body: some View {
        GeometryReader { geometry in
            VStack(spacing: 0) {
                switch viewRouter.currentWindow {
                case .home:
                    HomeView()
                case .settings:
                    SettingsView()
                }
                //Spacer()
                VStack(spacing: 0) {
                    Rectangle()
                        .frame(height: 0.5)
                        .foregroundColor(Color.theme.accent.opacity(0.2))
                    HStack {
                        Spacer()
                        TabBarItemView(viewRouter: viewRouter, assignedWindow: .home, width: geometry.size.width/5, height: geometry.size.height/36, systemIconName: "house.fill", tabName: "Home")
                        Spacer(minLength: geometry.size.width/7)
                        ZStack {
                            Image(systemName: "plus.circle.fill")
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .frame(width: geometry.size.width/8-6, height: geometry.size.width/8-6)
                                .foregroundStyle(Color.theme.green)
                        }
                        .offset(y: -geometry.size.height/8/8)
                        Spacer(minLength: geometry.size.width/7)
                        TabBarItemView(viewRouter: viewRouter, assignedWindow: .settings, width: geometry.size.width/5, height: geometry.size.height/36, systemIconName: "gear", tabName: "Settings")
                        Spacer()
                    }
                    .frame(width: geometry.size.width, height: geometry.size.height/10)
                    .background(Color.theme.white)
                }
            }
            .ignoresSafeArea(edges: .bottom)
        }
    }
}

#Preview {
    ContentView(viewRouter: ViewRouter())
}
