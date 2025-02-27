//
//  TapLessApp.swift
//  TapLess
//
//  Created by Liam Sebestyen on 2025-01-04.
//

import SwiftUI
import Firebase
//Works?
//Work on this today

//class AppDelegate: NSObject, UIApplicationDelegate {
//  func application(_ application: UIApplication,
//                   didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
//    FirebaseApp.configure() //configure firebase
//    return true //What am i doing lol
//  }
//}


//Here the app starts
@main
struct TapLessApp: App {
    
    init(){
        FirebaseApp.configure()
        print("Firebase configured!")
    }
    var body: some Scene {
        WindowGroup {
            NavigationStack {
                RootView()
            }
//            WelcomeView()
//            ContentView()
        }
    }
}
