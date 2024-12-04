//
//  LoginPresentationState.swift
//  SwiftUITemplate
//
//  Created by Gemuele Aludino on 12/3/24.
//

import SwiftUI
import Observation

@Observable
class LoginPresentationState {
    var credentials = LoginCredentials(userName: "", password: "")
    
    var loginPresented = true
    var tabViewPresented = false
}
