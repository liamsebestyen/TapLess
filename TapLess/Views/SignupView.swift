//
//  SignupView.swift
//  TapLess
//
//  Created by Liam Sebestyen on 2025-02-13.
//

import SwiftUI
//import FirebaseAuth

struct SignupView: View {
    @State private var email: String = ""
    @State private var password: String = ""
    @State private var confirmPassword: String = ""
    @State private var errorMessage: String = ""
    
    var body: some View {
        VStack{
            TextField("Email:", text: $email).autocorrectionDisabled(true)
                .textInputAutocapitalization(.never)
                .textFieldStyle(RoundedBorderTextFieldStyle())

            SecureField("Password", text: $password)
                          .textFieldStyle(RoundedBorderTextFieldStyle())

            if !errorMessage.isEmpty {
                           Text(errorMessage).foregroundColor(.red)
                       }
            
            Button("Sign Up!"){
                //Function Call
                print("User Signed Up!")
            }
                .buttonStyle(.borderedProminent)
        }
    }
}

//This will not work because there is no firebase SDK currently
private func signupUser(email: String, password: String){
    Auth.auth().createUser(withEmail: email, passowrd: password) {
        authResult, error in
        if let error = error {
            errorMessage = error.localizedDescription
        } else {
            print("User \(authResult!.user.email!) signed up successfully")
        }
        
    }
}

#Preview {
    SignupView()
}
