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

enum DoctorRoute: @preconcurrency Route, Hashable {
    case dashboard
    case list
    case create
    case detail(doctor: Doctor)
    
    @MainActor
    @ViewBuilder
    var destination: some View {
        switch self {
        case .dashboard:
            DoctorDashboard()
        case .list:
            DoctorList()
        case let .detail(doctor):
            DoctorDetail(doctor: doctor)
        case .create:
            DoctorCreate()
        }
    }
}
