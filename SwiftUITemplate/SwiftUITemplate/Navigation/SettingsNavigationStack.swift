//
//  SettingsNavigationStack.swift
//  SwiftUITemplate
//
//  Created by Gemuele Aludino on 12/3/24.
//

import SwiftUI

struct SettingsNavigationStack: View {
    @State private var router = SettingsRouter()
    
    var body: some View {
        NavigationStack(path: $router.routes) {
            router.navigate(to: .settings)
                .navigationDestination(for: SettingsRoute.self) { route in
                    router.navigate(to: route)
                }
        }
        .environment(router)
    }
}

@Observable
class SettingsRouter: @preconcurrency Router {
    var routes: [SettingsRoute] = []
    
    @MainActor
    @ViewBuilder
    func navigate(to route: SettingsRoute) -> some View {
        route.destination
    }
    
    func push(_ route: SettingsRoute) {
        routes.append(route)
    }
    
    func pop() {
        routes.removeLast()
    }
    
    func popToRoot() {
        routes.removeLast(routes.count)
    }
}

enum SettingsRoute: @preconcurrency Route, Hashable {
    case settings

    @MainActor
    @ViewBuilder
    var destination: some View {
        switch self {
        case .settings:
            Settings()
        }
    }
}
