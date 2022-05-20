//
//  LoginViewModel.swift
//  libraryApp
//
//  Created by Patryk Jastrzębski on 19/05/2022.
//

import Foundation
import SwiftUI
import Firebase

class LoginViewModel: ObservableObject {
    @Published var email: String = ""
    @Published var password: String = ""
    
    @AppStorage("log_status") var logStatus: Bool = false
    
    func loginUser() async throws {
        let _ = try await Auth.auth().signIn(withEmail: email, password: password)
        logStatus = true
    }
    
    func registerUser() async throws {
        let _ = try await Auth.auth().createUser(withEmail: email, password: password)
    }
}
