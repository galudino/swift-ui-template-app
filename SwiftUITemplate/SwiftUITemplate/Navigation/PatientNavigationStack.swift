//
//  PatientRoute.swift
//  SwiftUITemplate
//
//  Created by Gemuele Aludino on 11/27/24.
//

import SwiftUI

enum PatientRoute: @preconcurrency Route, Hashable {
    case dashboard
    case list
    case detail(patient: Patient)
   
    @MainActor
    @ViewBuilder
    static var rootView: some View {
        PatientDashboard()
    }

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
