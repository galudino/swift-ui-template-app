//
//  DoctorCreate.swift
//  SwiftUITemplate
//
//  Created by Gemuele Aludino on 12/2/24.
//

import SwiftUI

struct DoctorCreate: View {
    @Environment(ModelData.self) private var modelData

    @Environment(\.dismiss) var dismiss

    @State private var firstNameEntered = ""
    @State private var lastNameEntered = ""
    @State private var departmentEntered = ""

    private var allFieldsFilled: Bool {
        !(firstNameEntered.isEmpty || lastNameEntered.isEmpty || departmentEntered.isEmpty)
    }

    var body: some View {
        VStack {
            Form {
                headingText
                textFieldSection
                confirmNewDoctorButton
            }
        }
        .navigationTitle("Add New Doctor")
    }
    
    private var headingText: some View {
        Text("Add New Doctor")
            .listRowBackground(Rectangle().fill(.clear))
            .font(.title)
            .bold()
    }

    private var textFieldSection: some View {
        Section(content: {
            TextField("First Name", text: $firstNameEntered)
            TextField("Last Name", text: $lastNameEntered)
            TextField("Department", text: $departmentEntered)
        }, header: {
            Text("Doctor Information")
        })
    }
    
    private var confirmNewDoctorButtonLabel: some View {
        HStack {
            HStack {
                Image(systemName: "plus.circle.fill")
                Text("Confirm New Doctor")
            }
            .padding(EdgeInsets(top: 5, leading: 5, bottom: 5, trailing: 5))
            .frame(maxWidth: .infinity)
        }
    }

    private var confirmNewDoctorButton: some View {
        Button(action: {
            modelData
                .addDoctor(Doctor(firstName: firstNameEntered,
                                  lastName: lastNameEntered,
                                  department: departmentEntered))
            dismiss()
        }, label: {
            confirmNewDoctorButtonLabel
        })
        .buttonStyle(.borderedProminent)
        .listRowBackground(Rectangle().fill(.clear))
        .disabled(!allFieldsFilled)
    }
}

#Preview {
    DoctorCreate()
        .environment(ModelData())
}
