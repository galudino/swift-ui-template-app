//
//  LoginRoute.swift
//  SwiftUITemplate
//
//  Created by Gemuele Aludino on 12/3/24.
//

import SwiftUI

enum LoginRoute: @preconcurrency Route, Hashable {
    case login
    case connecting(loginCredentials: LoginCredentials)
    
    @MainActor
    @ViewBuilder
    static var rootView: some View {
        Login()
    }
    
    @MainActor
    @ViewBuilder
    var destination: some View {
        switch self {
        case .login:
            Login()
        case .connecting(let loginCredentials):
            Connecting(credentials: loginCredentials)
        }
    }
}
