//
//  TapLessApp.swift
//  TapLess
//
//  Created by Liam Sebestyen on 2025-01-04.
//

import SwiftUI
import FirebaseCore
class AppDelegate: NSObject, UIApplicationDelegate {
  func application(_ application: UIApplication,
                   didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
    FirebaseApp.configure()
    return true
  }
}

@main
struct TapLessApp: App {
    var body: some Scene {
        WindowGroup {
            WelcomeView()
//            ContentView()
        }
    }
}
