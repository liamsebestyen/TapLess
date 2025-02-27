//
//  SignInViewEmail.swift
//  TapLess
//
//  Created by Liam Sebestyen on 2025-02-25.
//

import SwiftUI
@MainActor
final class SignInEmailViewModel: ObservableObject {
    @Published var email: String = ""
    @Published var password: String = ""
    
    func signIn ()  {
        guard !email.isEmpty, !password.isEmpty  else {
            print("No email or password found")
            //Future could add more restrictions to passwords.
            return }
        
        Task {
            do {
                let returnedUser = try await AuthenticationManager.shared.createUser(email: email, password: password)
                print("Success")
                print(returnedUser)
            } catch {
                print("error:  \(error)")
                //Should communicate this with user.
            }
        }
        
        
        
        }
    }


struct SignInViewEmail: View {
    @State private var viewModel = SignInEmailViewModel()
    
    var body: some View {
        VStack{
            TextField("Email ...", text: $viewModel.email)
                .padding()
                .background(Color.gray.opacity(0.4))
                .cornerRadius(10)
            
            SecureField("Password ...", text: $viewModel.password)
                .padding()
                .background(Color.gray.opacity(0.4))
                .cornerRadius(10)
            
            
            Button {
                viewModel.signIn()
            } label: {
                Text("Sign In with Email")
                    .font(.headline)
                    .foregroundColor(.white)
                    .frame(height: 55)
                    .frame(maxWidth: .infinity)
                    .background(Color.blue)
                    .cornerRadius(10)
            }
            Spacer()
        }
        .padding()
        .navigationTitle("Sign In With Email")
    }
}

#Preview {
    NavigationStack{
        SignInViewEmail()
    }
}
