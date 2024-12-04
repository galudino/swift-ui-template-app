//
//  PatientDetailView.swift
//  SwiftUITemplate
//
//  Created by Gemuele Aludino on 11/27/24.
//

import SwiftUI

struct PatientDetail: View {
    @Environment(PatientRouter.self) private var router
    @Environment(ModelData.self) private var modelData
    
    @State private var presentRemovePatientAlert = false
    
    private let patient: Patient

    init(patient: Patient) {
        self.patient = patient
    }

    var body: some View {
        VStack {
            List {
                patientListRowSection
                removePatientButton
            }
        }
        .navigationTitle("Patient Detail")
        .alert("Remove Patient: \(patient.lastName), \(patient.firstName)",
               isPresented: $presentRemovePatientAlert,
               actions: {
                   Button("Yes", role: .destructive, action: removePatientAndNavigateBack)
                   Button("Cancel", role: .cancel, action: {})
               }, message: {
                   Text("Are you sure you want to remove this patient?")
               })
    }
    
    var patientListRowSection: some View {
        Section {
            ListRow(label: "Name", detail: "\(patient.firstName) \(patient.lastName)")
            ListRow(label: "Patient ID", detail: patient.id.description)
        }
    }
    
    var removePatientButtonLabel: some View {
        HStack {
            HStack {
                Image(systemName: "minus.circle.fill")
                Text("Remove Patient")
            }
            .padding(EdgeInsets(top: 5, leading: 10, bottom: 5, trailing: 10))
            .frame(maxWidth: .infinity)
        }
    }
    
    var removePatientButton: some View {
        Button(action: {
            presentRemovePatientAlert = true
        }, label: {
            removePatientButtonLabel
        })
        .listRowBackground(Rectangle().fill(.clear))
        .buttonStyle(.borderedProminent)
        .padding(EdgeInsets(top: 0, leading: 10, bottom: 0, trailing: 10))
    }
    
    func removePatientAndNavigateBack() {
        _ = modelData.removePatient(patient)
        router.pop()
    }
}

#Preview {
    PatientDetail(patient: Patient(firstName: "Gem", lastName: "Aludino", id: 7777))
        .environment(PatientRouter())
        .environment(ModelData())
}
