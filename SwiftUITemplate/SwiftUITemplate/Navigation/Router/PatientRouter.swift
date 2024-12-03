//
//  PatientRouter.swift
//  SwiftUITemplate
//
//  Created by Gemuele Aludino on 12/2/24.
//

import SwiftUI

@Observable
class PatientRouter: @preconcurrency Router {
    var routes: [PatientRoute] = []

    @MainActor
    @ViewBuilder
    func navigate(to route: PatientRoute) -> some View {
        route.destination
    }
    
    func push(_ route: PatientRoute) {
        routes.append(route)
    }
    
    func pop() {
        routes.removeLast()
    }
    
    func popToRoot() {
        routes.removeLast(routes.count)
    }
}
