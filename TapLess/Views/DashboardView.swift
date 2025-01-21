//
//  DashboardView.swift
//  TapLess
//
//  Created by Liam Sebestyen on 2025-01-13.
//

import SwiftUI

struct DashboardView: View {
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
            Customize()
        }
        
}
    }
}

#Preview {
    DashboardView()
}
