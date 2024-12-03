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
            _ = modelData.removePatient(patient)
            router.pop()
        }, label: {
            removePatientButtonLabel
        })
        .listRowBackground(Rectangle().fill(.clear))
        .buttonStyle(.borderedProminent)
        .padding(EdgeInsets(top: 0, leading: 10, bottom: 0, trailing: 10))
    }
}

#Preview {
    PatientDetail(patient: Patient.previews[0])
        .environment(PatientRouter())
        .environment(ModelData())
}
