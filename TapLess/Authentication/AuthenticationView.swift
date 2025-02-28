//
//  AuthenticationView.swift
//  TapLess
//
//  Created by Liam Sebestyen on 2025-02-25.
//

import SwiftUI

struct AuthenticationView: View {
    @Binding var showSignInView: Bool
    var body: some View {
        VStack{
            NavigationLink{
                SignInViewEmail(showSignInView: .constant(false))
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
        .navigationTitle("Sign In")
    }
}

#Preview {
    NavigationStack{
        AuthenticationView(showSignInView: .constant(false))
    }
}
