//
//  DoctorDetail.swift
//  SwiftUITemplate
//
//  Created by Gemuele Aludino on 11/27/24.
//

import SwiftUI

struct DoctorDetail: View {
    @Environment(DoctorRouter.self) private var router
    @Environment(ModelData.self) private var modelData

    private var doctor: Doctor

    init(doctor: Doctor) {
        self.doctor = doctor
    }

    var body: some View {
        VStack {
            List {
                doctorListRowSection
                removeDoctorButton
            }
        }
        .navigationTitle("Doctor Detail")
    }

    private var doctorListRowSection: some View {
        Section {
            ListRow(label: "Name", detail: "Dr. \(doctor.firstName) \(doctor.lastName)")
            ListRow(label: "Department", detail: doctor.department)
        }
    }

    private var removeDoctorButtonLabel: some View {
        HStack {
            HStack {
                Image(systemName: "minus.circle.fill")
                Text("Remove Doctor")
            }
            .padding(EdgeInsets(top: 5, leading: 10, bottom: 5, trailing: 10))
            .frame(maxWidth: .infinity)
        }
    }

    private var removeDoctorButton: some View {
        Button(action: {
            _ = modelData.removeDoctor(doctor)
            router.pop()
        }, label: {
            removeDoctorButtonLabel
        })
        .listRowBackground(Rectangle().fill(.clear))
        .buttonStyle(.borderedProminent)
        .padding(EdgeInsets(top: 0, leading: 10, bottom: 0, trailing: 10))
    }
}

#Preview {
    DoctorDetail(doctor: Doctor(firstName: "Gregory", lastName: "House", department: "Diagnostics"))
        .environment(DoctorRouter())
        .environment(ModelData(networkService: FakeNetworkService()))
}
