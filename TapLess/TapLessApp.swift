//
//  TapLessApp.swift
//  TapLess
//
//  Created by Liam Sebestyen on 2025-01-04.
//

import SwiftUI
import FirebaseCore
import FirebaseAuth

//Works?

class AppDelegate: NSObject, UIApplicationDelegate {
  func application(_ application: UIApplication,
                   didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
    FirebaseApp.configure() //configure firebase
    return true
  }
}

@main
struct TapLessApp: App {
    @UIApplicationDelegateAdaptor(AppDelegate.self) var delegate // register delegate for firebase set up
    var body: some Scene {
        WindowGroup {
            WelcomeView()
//            ContentView()
        }
    }
}
