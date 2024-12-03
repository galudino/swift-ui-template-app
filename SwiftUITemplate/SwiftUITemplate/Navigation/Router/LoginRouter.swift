//
//  LoginRouter.swift
//  SwiftUITemplate
//
//  Created by Gemuele Aludino on 12/3/24.
//

import SwiftUI

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
