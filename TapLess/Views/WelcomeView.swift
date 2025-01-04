//
//  WelcomeView.swift
//  TapLess
//
//  Created by Liam Sebestyen on 2025-01-04.
//

import SwiftUI

struct WelcomeView: View {
    
    var body: some View {
        NavigationView {
            ZStack {
                // Create the background colour gradient
                LinearGradient(gradient: Gradient(colors: [Color.blue.opacity(0.75), Color.purple.opacity(0.8)]),
                               startPoint: .topLeading,
                               endPoint: .bottomTrailing)
                .edgesIgnoringSafeArea(.all)
                
                
                
                VStack(spacing: 25) {
                    
                    Image(systemName: "clock.arrow.circlepath")  // placeholder for now
                        .resizable()
                        .scaledToFit()
                        .frame(width: 120, height: 120)
                        .foregroundColor(.white)
                        .padding(.bottom, 20)
                    
                    Text("Welcome to App")
                        .font(.largeTitle)
                        .fontWeight(.bold)
                        .foregroundColor(.white)
                        .multilineTextAlignment(.center)
                        .padding(.horizontal, 20)
                    
                    Text("Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s")
                        .font(.title3)
                        .foregroundColor(.white.opacity(0.9))
                        .multilineTextAlignment(.center)
                        .padding(.horizontal, 30)
                    
                    NavigationLink(destination: DashboardView()) {
                        Text("Get Started!")
                            .font(.title2)
                            .bold()
                            .foregroundColor(.white)
                            .padding()
                            .frame(maxWidth: .infinity)
                            .background(
                                        LinearGradient(
                                            gradient:
                                                Gradient(colors: [Color.blue.opacity(0.75), Color.purple.opacity(0.8)]),
                                                startPoint: .topLeading,
                                                endPoint: .bottomTrailing
                                                )
                                        )
                            .cornerRadius(10)
                            .padding(.horizontal, 25)
                        
                        
                    }
                }
                
                }
        }
    }
}
    
struct WelcomeView_Previews: PreviewProvider {
    static var previews:  some View{
        WelcomeView()
    }
}

struct DashboardView: View {
    var body: some View {
        Text("This is the dashboard view!")
    }
}

