//
//  PatientCreate.swift
//  SwiftUITemplate
//
//  Created by Gemuele Aludino on 12/2/24.
//

import SwiftUI

struct PatientCreate: View {
    @Environment(ModelData.self) private var modelData
    
    @Environment(\.dismiss) var dismiss

    @State private var firstNameEntered = ""
    @State private var lastNameEntered = ""

    private var allFieldsFilled: Bool {
        !(firstNameEntered.isEmpty || lastNameEntered.isEmpty)
    }

    var body: some View {
        VStack {
            Form {
                headingText
                textFieldSection
                confirmNewPatientButton
            }
        }
        .navigationTitle("Add New Patient")
    }
    
    private var headingText: some View {
        Text("Add New Patient")
            .listRowBackground(Rectangle().fill(.clear))
            .font(.title)
            .bold()
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
            modelData.addPatient(Patient(firstName: firstNameEntered, lastName: lastNameEntered, id: Int.random(in: 2000...3000)))
            dismiss()
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
        .environment(ModelData())
}
