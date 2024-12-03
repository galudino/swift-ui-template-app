//
//  PatientCreate.swift
//  SwiftUITemplate
//
//  Created by Gemuele Aludino on 12/2/24.
//

import SwiftUI

struct PatientCreate: View {
    @Environment(PatientRouter.self) private var router
    @Environment(ModelData.self) private var modelData

    @State private var firstNameEntered = ""
    @State private var lastNameEntered = ""

    private var allFieldsFilled: Bool {
        !(firstNameEntered.isEmpty || lastNameEntered.isEmpty)
    }

    var body: some View {
        VStack(alignment: .leading) {
            Form {
                textFieldSection
                confirmNewPatientButton
            }
        }
        .navigationTitle("Add New Patient")
    }
    
    private var textFieldSection: some View {
        Section(content: {
            TextField("First Name", text: $firstNameEntered)
            TextField("Last Name", text: $lastNameEntered)
        }, header: {
            Text("Patient Information")
        })
    }
    
    private var confirmNewPatientButtonLabel: some View {
        HStack {
            HStack {
                Image(systemName: "plus.circle.fill")
                Text("Confirm New Patient")
            }
            .padding(EdgeInsets(top: 5, leading: 5, bottom: 5, trailing: 5))
            .frame(maxWidth: .infinity)
        }
    }
    
    private var confirmNewPatientButton: some View {
        Button(action: {
            modelData.addPatient(Patient(firstName: firstNameEntered, lastName: lastNameEntered))
            router.pop()
        }) {
            confirmNewPatientButtonLabel
        }
        .buttonStyle(.borderedProminent)
        .listRowBackground(Rectangle().fill(.clear))
        .disabled(!allFieldsFilled)
    }
}

#Preview {
    PatientCreate()
        .environment(PatientRouter())
        .environment(ModelData())
}
