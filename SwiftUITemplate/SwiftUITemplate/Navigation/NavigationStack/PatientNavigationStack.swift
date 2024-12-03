//
//  PatientNavigationStack.swift
//  SwiftUITemplate
//
//  Created by Gemuele Aludino on 11/27/24.
//

import SwiftUI

struct PatientNavigationStack: View {
    @State private var router = PatientRouter()

    var body: some View {
        NavigationStack(path: $router.routes) {
            router.navigate(to: .dashboard)
                .navigationDestination(for: PatientRoute.self) { route in
                    router.navigate(to: route)
                }
        }
        .environment(router)
    }
}
