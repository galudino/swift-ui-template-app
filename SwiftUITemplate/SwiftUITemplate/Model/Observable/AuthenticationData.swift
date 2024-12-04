//
//  AuthenticationModel.swift
//  SwiftUITemplate
//
//  Created by Gemuele Aludino on 12/3/24.
//

import SwiftUI
import Observation

@Observable
class AuthenticationData {
    var loginCredentials = LoginCredentials(userName: "", password: "")
    
    var loginPresented = true
    var tabViewPresented = false
    
    var allFieldsFilled: Bool {
        !(loginCredentials.userName.isEmpty || loginCredentials.password.isEmpty)
    }
    
    static func evaluateCredentials(_ credentials: LoginCredentials) -> Bool {
        /// Only one account/password combination works for this app. It's just a demo!
        credentials.userName == "Admin" && credentials.password == "1234"
    }
}
