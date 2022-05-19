//
//  LoginViewModel.swift
//  libraryApp
//
//  Created by Patryk Jastrzębski on 19/05/2022.
//

import Foundation
import SwiftUI

class LoginViewModel: ObservableObject {
    @Published var login: String = ""
    @Published var password: String = ""
    
    
}
