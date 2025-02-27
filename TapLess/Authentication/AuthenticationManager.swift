//
//  AuthenticationManager.swift
//  TapLess
//
//  Created by Liam Sebestyen on 2025-02-25.
//

import Foundation
import Firebase
import FirebaseAuth

struct AuthDataResultModel {
    let uid: String
    let email: String?
    let photoURL: String?
    
    
    init (user: User) {
        self.uid = user.uid
        self.email = user.email
        self.photoURL = user.photoURL?.absoluteString
        
    }
}

final class AuthenticationManager {
    static let shared = AuthenticationManager()
    //Only instance of this class
    private init() {}
    
    //Singleton design pattern which is bad for scalability, many limitations with testing and with dependencies (confused from video).
    //He has a video for this with dependency injection later for the advanced videos.
    //Probably not best method for production apps.
    
    func createUser(email: String, password: String) async throws -> AuthDataResultModel {
        let authDataResult = try await Auth.auth().createUser(withEmail: email, password: password)
        //        let result = AuthDataResultModel(
        //            uuid: authDataResult.user.uid,
        //            email: authDataResult.user.email,
        //            photoURL: authDataResult.user.photoURL?.absoluteString)
        //    }
        
        return AuthDataResultModel(user: authDataResult.user)
    }
    
    func getAuthenticatedUser() throws -> AuthDataResultModel {
        guard let user = Auth.auth().currentUser  else {
            throw URLError(.badServerResponse)
        }
        
        return AuthDataResultModel(user: user)
    }
    
    func signOut() throws {
      try  Auth.auth().signOut()
    }
    

}
