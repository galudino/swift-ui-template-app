//
//  TabSelection.swift
//  SwiftUITemplate
//
//  Created by Gemuele Aludino on 11/27/24.
//

import SwiftUI

// MARK: - TabSelection

enum TabSelection: Hashable, Identifiable, CaseIterable {
    case patientDashboard
    case doctorDashboard
    case settings
    
    var id: Self { self }

    @MainActor
    @ViewBuilder
    var label: some View {
        switch self {
        case .patientDashboard:
            Label("Patients", systemImage: "person.3.fill")
        case .doctorDashboard:
            Label("Doctors", systemImage: "cross.fill")
        case .settings:
            Label("Settings", systemImage: "gear")
        }
    }

    @MainActor
    @ViewBuilder
    var navigationStack: some View {
        switch self {
        case .patientDashboard:
            PatientNavigationStack()
        case .doctorDashboard:
            DoctorNavigationStack()
        case .settings:
            SettingsNavigationStack()
        }
    }
}
