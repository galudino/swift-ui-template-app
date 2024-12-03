//
//  DoctorRouter.swift
//  SwiftUITemplate
//
//  Created by Gemuele Aludino on 12/2/24.
//

import SwiftUI

@Observable
class DoctorRouter: @preconcurrency Router {
    var routes: [DoctorRoute] = []
    
    @MainActor
    @ViewBuilder
    func navigate(to route: DoctorRoute) -> some View {
        route.destination
    }
    
    func push(_ route: DoctorRoute) {
        routes.append(route)
    }
    
    func pop() {
        routes.removeLast()
    }
    
    func popToRoot() {
        routes.removeLast(routes.count)
    }
}
