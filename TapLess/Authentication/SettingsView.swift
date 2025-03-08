//
//  SettingsView.swift
//  TapLess
//
//  Created by Liam Sebestyen on 2025-02-27.
//

import SwiftUI

@MainActor
final class SettingsViewModel: ObservableObject {
    
    
    
    func signOut () throws {
        try AuthenticationManager.shared.signOut()
    }
    
    func resetPassword() async  throws {
        let authUser = try AuthenticationManager.shared.getAuthenticatedUser()
        guard let email = authUser.email else {
            throw URLError(.fileDoesNotExist)
        }
        try await AuthenticationManager.shared.resetPassword(email: email)
    }
    
    func updatePassword() async  throws {
        let password = "hello123"
        try await AuthenticationManager.shared.updatePassword(password: password)
    }
        
        
        func updateEmail() async throws {
             try await AuthenticationManager.shared.updateEmail()
        }
    }

struct SettingsView: View {
    @StateObject private var viewModel =  SettingsViewModel()
    @Binding var showSignInView: Bool
    var body: some View {
        NavigationStack{
            List {
                Button("Log Out"){
                    Task {
                        do {
                            try viewModel.signOut()
                            showSignInView = true
                        } catch {
                            print(error)
                            //Eventually show this to the user.
                        }
                    }
                    
                }
                
                Section{
                    Button ("Reset Password"){
                        Task {
                            do {
                                try await viewModel.resetPassword()
                                print("Password RESET sent!")
                                //Eventually show this to the user.
                                
                            } catch {
                                print(error)
                                //Eventually show this to the user.
                            }
                        }
                    }
                    
                    Button ("Update Password"){
                        Task {
                            do {
                                try await viewModel.updatePassword()
                                print("Password RESET sent!")
                                //Eventually show this to the user.
                                
                            } catch {
                                print(error)
                                //Eventually show this to the user.
                                //I plan on using reset email to do this.
                            }
                        }
                    }
                    
                    Button ("Update Email"){
                        Task {
                            do {
                                try await viewModel.updateEmail()
                                print("Password RESET sent!")
                                //Eventually show this to the user.
                                
                            } catch {
                                print(error)
                                //Eventually show this to the user.
                            }
                            //Honestly I may just remove this one.
                        }
                    }
                    
                } header : {
                    Text("Email")
                }
            }
            .navigationBarTitle("settings")
        }
    }
}

#Preview {
    SettingsView(showSignInView: .constant(false))
}
