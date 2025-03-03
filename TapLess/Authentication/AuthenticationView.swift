//
//  AuthenticationView.swift
//  TapLess
//
//  Created by Liam Sebestyen on 2025-02-25.
//

import SwiftUI
import AuthenticationServices
import CryptoKit


@MainActor
final class AuthenticationViewModel:  ObservableObject {
    let signInAppleHelper = SignInAppleHelper()

    
    func signInApple() async throws {
        let helper = signInAppleHelper()
        let tokens = try await helper.startSignInWithAppleFlow()
        try await AuthenticationManager.shared.signInWithApple(tokens: tokens)
    }
}


struct AuthenticationView: View {
    @Binding var showSignInView: Bool
    var body: some View {
        VStack{
            NavigationLink{
                SignInViewEmail(showSignInView: $showSignInView)
            } label: {
                Text("Sign In with Email")
                    .font(.headline)
                    .foregroundColor(.white)
                    .frame(height: 55)
                    .frame(maxWidth: .infinity)
                    .background(Color.blue)
                    .cornerRadius(10)
            }
            
          
            
            Button(action: {
                do {
                    try await viewModel.signInApple()
                    showSignInView = false
                    
                } catch {
                    print(error)
                }
                
            }, label: {
                SignInWithAppleButtonViewRepresentable(type: .default, style: .black)
                    .allowsHitTesting(false)
            })
            .frame(height: 55)
           
    
            

            
            Spacer()
        }
        .padding()
        .navigationTitle("Sign In")
    }
}

#Preview {
    NavigationStack{
        AuthenticationView(showSignInView: .constant(false))
    }
}
