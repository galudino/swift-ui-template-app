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
