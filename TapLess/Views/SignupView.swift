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
    @State private var error: String?
    
    var body: some View {
        VStack{
            TextField("Email:", text: $email).autocorrectionDisabled(true)
                .textInputAutocapitalization(.never)
        }
    }
}

#Preview {
    SignupView()
}
