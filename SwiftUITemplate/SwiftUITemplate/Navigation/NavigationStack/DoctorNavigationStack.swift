//
//  DoctorNavigationStack.swift
//  SwiftUITemplate
//
//  Created by Gemuele Aludino on 11/27/24.
//

import SwiftUI

struct DoctorNavigationStack: View {
    @State private var router = DoctorRouter()

    var body: some View {
        NavigationStack(path: $router.routes) {
            router.navigate(to: .dashboard)
                .navigationDestination(for: DoctorRoute.self) { route in
                    router.navigate(to: route)
                }
        }
        .environment(router)
    }
}
