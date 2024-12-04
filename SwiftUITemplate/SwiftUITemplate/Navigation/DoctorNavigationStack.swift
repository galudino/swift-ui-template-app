//
//  DoctorNavigationStack.swift
//  SwiftUITemplate
//
//  Created by Gemuele Aludino on 11/27/24.
//

import SwiftUI

struct DoctorNavigationStack: View {
    @State private var router = Router<DoctorRoute>()

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

enum DoctorRoute: @preconcurrency Route, Hashable {
    case dashboard
    case list
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
        }
    }
}
