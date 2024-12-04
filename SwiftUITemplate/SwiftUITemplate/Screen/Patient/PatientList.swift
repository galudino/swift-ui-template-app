//
//  PatientList.swift
//  SwiftUITemplate
//
//  Created by Gemuele Aludino on 11/27/24.
//

import SwiftUI

struct PatientList: View {
    @Environment(FakeNetworkService.self) private var networkService
    @Environment(PatientRouter.self) private var router
    @Environment(ModelData.self) private var modelData

    @State private var presentAddPatientSheet = false

    @State private var isLoading = false
    @State private var isRefreshing = false
    
    @State private var doLoad = true

    var body: some View {
        VStack {
            if isLoading && !isRefreshing {
                ProgressView()
                Text("Please wait...")
            } else {
                patientList
            }
        }
        .navigationTitle("Patient List")
        .toolbar {
            ToolbarItem(placement: .topBarTrailing) {
                addNewPatientButton
            }
        }
        .onAppear {
            if doLoad {
                Task { @MainActor in
                    isLoading = true
                    try await modelData.fetchPatients()
                    isLoading = false
                }
            }
        }
        .refreshable {
            Task { @MainActor in
                isLoading = true
                isRefreshing = true
                
                try await modelData.fetchPatients()
                
                isRefreshing = false
                isLoading = false
            }
        }
        .sheet(isPresented: $presentAddPatientSheet) {
            PatientCreate()
        }
    }

    private var patientList: some View {
        List {
            Section(content: {
                ForEach(modelData.patients, id: \.self) { patient in
                    Button("\(patient.lastName), \(patient.firstName)") {
                        /// Ensures we don't load again when navigating back
                        doLoad = false
                        router.push(.detail(patient: patient))
                    }
                }

            }, header: {
                Text("Total patient count: \(modelData.patients.count)")
            })
        }
    }

    private var addNewPatientButton: some View {
        Button("Add New Patient") {
            presentAddPatientSheet.toggle()
        }
    }
}

#Preview {
    PatientList()
        .environment(FakeNetworkService())
        .environment(PatientRouter())
        .environment(ModelData(networkService: FakeNetworkService()))
}
