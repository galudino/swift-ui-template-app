//
//  LoginRoute.swift
//  SwiftUITemplate
//
//  Created by Gemuele Aludino on 12/3/24.
//

import SwiftUI

enum LoginRoute: @preconcurrency Route, Hashable {
    case login
    case connecting(credentials: LoginCredentials)
    
    @MainActor
    @ViewBuilder
    var destination: some View {
        switch self {
        case .login:
            Login(loginPresented: .constant(true))
        case .connecting(let credentials):
            Connecting(credentials: credentials)
        }
    }
}
