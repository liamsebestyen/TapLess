//
//  AuthenticationViewModel.swift
//  TapLess
//
//  Created by Liam Sebestyen on 2025-03-07.
//

import Foundation

@MainActor
final class AuthenticationViewModel: ObservableObject {
    func signInApple() async throws {
           let helper = SignInAppleHelper()
           let tokens = try await helper.startSignInWithAppleFlow()
           let authDataResult = try await AuthenticationManager.shared.signInWithApple(tokens: tokens)
//           let user = DBUser(auth: authDataResult)
//           try await UserManager.shared.createNewUser(user: user)
       }
}
