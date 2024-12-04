//
//  LoginNavigationStack.swift
//  SwiftUITemplate
//
//  Created by Gemuele Aludino on 12/3/24.
//

import SwiftUI

struct LoginNavigationStack: View {
    @State private var router = LoginRouter()
    
    var body: some View {
        NavigationStack(path: $router.routes) {
            router.navigate(to: .login)
                .navigationDestination(for: LoginRoute.self) { route in
                    router.navigate(to: route)
                }
        }
        .environment(router)
    }
}

@Observable
class LoginRouter: @preconcurrency Router {
    var routes: [LoginRoute] = []
    
    @MainActor
    @ViewBuilder
    func navigate(to route: LoginRoute) -> some View {
        route.destination
    }
    
    func push(_ route: LoginRoute) {
        routes.append(route)
    }
    
    func pop() {
        routes.removeLast()
    }
    
    func popToRoot() {
        routes.removeLast(routes.count)
    }
}

enum LoginRoute: @preconcurrency Route, Hashable {
    case login
    case connecting(loginCredentials: LoginCredentials)
    
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
