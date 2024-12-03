//
//  DoctorRoute.swift
//  SwiftUITemplate
//
//  Created by Gemuele Aludino on 11/27/24.
//

import SwiftUI

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
