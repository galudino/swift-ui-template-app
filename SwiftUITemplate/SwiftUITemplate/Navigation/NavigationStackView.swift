//
//  NavigationStackView.swift
//  SwiftUITemplate
//
//  Created by Gemuele Aludino on 12/5/24.
//

import SwiftUI

struct NavigationStackView<RouteType: Route>: View {
    @State private var router = Router<RouteType>()
    
    var body: some View {
        NavigationStack(path: $router.routes) {
            RouteType.rootView
                .navigationDestination(for: RouteType.self) { route in
                    router.navigate(to: route)
                }
        }
        .environment(router)
    }
}
