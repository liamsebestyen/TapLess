//
//  DashboardView.swift
//  TapLess
//
//  Created by Liam Sebestyen on 2025-01-13.
//

import SwiftUI

struct DashboardView: View {
    
    var gradientBackground : some View {
        
        LinearGradient(gradient: Gradient(colors: [Color.blue.opacity(0.75), Color.purple.opacity(0.8)]),
                       startPoint: .topLeading,
                       endPoint: .bottomTrailing)
        .edgesIgnoringSafeArea(.all)
    }
    
    var body: some View {
TabView {
    
    Text("Home")
    
    .tabItem {
        Label("Home", systemImage: "house")
    }
    
    Text("Profile")
    .tabItem {
        
        Label("Profile", systemImage: "person")
    }
    Customize()
    .tabItem {
            Label("Customize", systemImage: "sparkle.magnifyingglass" )
            .background(gradientBackground)
            Customize()
        }
        
}
    }
}

#Preview {
    DashboardView()
}
