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

    @State private var presentAddPatientModal = false

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
                Button("Add New Patient") {
                    router.push(.create)
                }
            }
        }
        .onAppear {
            if doLoad {
                Task { @MainActor in
                    isLoading = true
                    
                    modelData.patients = try await networkService.fetchPatients()
                    modelData.patients.sort(by: { $0.lastName < $1.lastName })
                    
                    isLoading = false
                }
            }
        }
        .refreshable {
            Task { @MainActor in
                isLoading = true
                isRefreshing = true
                
                modelData.patients = try await networkService.fetchPatients()
                modelData.patients.sort(by: { $0.lastName < $1.lastName })
                isRefreshing = false
                
                isLoading = false
            }
        }
        .sheet(isPresented: $presentAddPatientModal) {
            PatientCreate()
        }
    }

    private var patientList: some View {
        @Bindable var modelData = modelData

        return List {
            Section(content: {
                ForEach($modelData.patients, id: \.self) { $patient in
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
            presentAddPatientModal.toggle()
        }
    }
}

#Preview {
    PatientList()
        .environment(FakeNetworkService())
        .environment(PatientRouter())
        .environment(ModelData(networkService: FakeNetworkService()))
}
