//
//  SettingsNavigationStack.swift
//  SwiftUITemplate
//
//  Created by Gemuele Aludino on 12/3/24.
//

import SwiftUI

struct SettingsNavigationStack: View {
    @State private var router = Router<SettingsRoute>()
    
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
