//
//  FirebaseUILoginView.swift
//  TapLess
//
//  Created by Liam Sebestyen on 2025-02-18.
//

import SwiftUI
import FirebaseCore
import FirebaseAuthUI


struct FirebaseUILoginView: View {
    
    var actionCodeSettings = ActionCodeSettings()
    actionCodeSettings.url = URL(string: "https://example.firebasestorage.app")
    actionCodeSettings.handleCodeInApp = true
    actionCodeSettings.setAndroidPackageName("com.firebase.example", installIfNotAvailable: false, minimumVersion: "12")

    let provider = FUIEmailAuth(authUI: FUIAuth.defaultAuthUI()!,
                                signInMethod: FIREmailLinkAuthSignInMethod,
                                forceSameDevice: false,
                                allowNewEmailAccounts: true,
                                actionCodeSetting: actionCodeSettings)
    
    FUIAuth.defaultAuthUI()!.handleOpen(url, sourceApplication: sourceApplication)
    //Moving to video implementation
    
    var body: some View {
        Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
    }
}

#Preview {
    FirebaseUILoginView()
}
