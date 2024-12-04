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

enum PatientRoute: @preconcurrency Route, Hashable {
    case dashboard
    case list
    case detail(patient: Patient)

    @MainActor
    @ViewBuilder
    var destination: some View {
        switch self {
        case .dashboard:
            PatientDashboard()
        case .list:
            PatientList()
        case let .detail(patient):
            PatientDetail(patient: patient)
        }
    }
}
