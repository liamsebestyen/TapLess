//
//  AuthenticationView.swift
//  TapLess
//
//  Created by Liam Sebestyen on 2025-02-25.
//

import SwiftUI
import AuthenticationServices

struct SignInWithAppleButtonViewRepresentable: UIViewRepresentable {
    
    let type: ASAuthorizationAppleIDButton.ButtonType
    let style: ASAuthorizationAppleIDButton.Style
    
    func makeUIView(context: Context) -> ASAuthorizationAppleIDButton {
        return ASAuthorizationAppleIDButton(authorizationButtonType: type, authorizationButtonStyle: style)
    }
    
    func updateUIView(_ uiView:  ASAuthorizationAppleIDButton, context: Context) {
        
    }
    
}

@MainActor
final class AuthenticationViewModel: ObservableObject {
    func signInApple() async throws {
        
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
            }).frame(height: 55)

            
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
