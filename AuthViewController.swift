// AuthViewController.swift
import UIKit
import Firebase
import FirebaseAuthUI

class AuthViewController: UIViewController, FUIAuthDelegate {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        presentFirebaseAuth()
    }
    
    func presentFirebaseAuth() {
        guard let authUI = FUIAuth.defaultAuthUI() else { return }
        authUI.delegate = self
        
        // Configure providers (e.g., Email, Apple, etc.)
        authUI.providers = [FUIEmailAuth()]
        
        let authViewController = authUI.authViewController()
        authViewController.modalPresentationStyle = .fullScreen
        present(authViewController, animated: true, completion: nil)
    }
    
    // FUIAuthDelegate method
    func authUI(_ authUI: FUIAuth, didSignInWith user: User?, error: Error?) {
        if let error = error {
            print("Error during sign-in: \(error.localizedDescription)")
            return
        }
        // Handle successful sign-in (e.g., dismiss auth UI or update state)
        dismiss(animated: true, completion: nil)
    }
}
