//
//  RootView.swift
//  TapLess
//
//  Created by Liam Sebestyen on 2025-02-27.
//

import SwiftUI

struct RootView: View {
    @State private var showSignInView: Bool = false
    var body: some View {
        ZStack{
            NavigationStack{
                SettingsView(showSignInView: $showSignInView)
            }
        }.onAppear{
            //fetch if user authenticated
            let authuser = try? AuthenticationManager.shared.getAuthenticatedUser()
            self.showSignInView = authuser == nil
            //return true if authuser is nil
            
        }.fullScreenCover(isPresented: $showSignInView){
            NavigationView{
                AuthenticationView(showSignInView: $showSignInView)
            }
        }
    }
}
#Preview {
    RootView()
}
