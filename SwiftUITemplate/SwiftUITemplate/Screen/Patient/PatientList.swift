//
//  PatientList.swift
//  SwiftUITemplate
//
//  Created by Gemuele Aludino on 11/27/24.
//

import SwiftUI

struct PatientList: View {
    @Environment(PatientRouter.self) private var router
    @Environment(ModelData.self) private var modelData
    
    @State private var presentAddPatientModal = false

    var body: some View {
        VStack {
            patientList
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
            modelData.patients.sort(by: { $0.lastName < $1.lastName })
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
        .environment(PatientRouter())
        .environment(ModelData())
}
