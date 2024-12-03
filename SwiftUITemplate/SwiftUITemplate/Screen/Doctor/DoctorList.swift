//
//  DoctorList.swift
//  SwiftUITemplate
//
//  Created by Gemuele Aludino on 11/27/24.
//

import SwiftUI

struct DoctorList: View {
    @Environment(DoctorRouter.self) private var router
    @Environment(ModelData.self) private var modelData
    
    @State private var presentAddDoctorModal = false

    var body: some View {
        VStack {
            doctorList
        }
        .navigationTitle("Doctor List")
        .toolbar {
            ToolbarItem(placement: .topBarTrailing) {
                addNewDoctorButton
            }
        }
        .onAppear {
            modelData.doctors.sort(by: { $0.lastName < $1.lastName })
        }
        .sheet(isPresented: $presentAddDoctorModal) {
            DoctorCreate()
        }
    }
    
    private var doctorList: some View {
        List {
            ForEach(modelData.doctorDepartmentsSortedAscending, id: \.self) { header in
                Section(content: {
                    if let doctors = modelData.doctorsGroupedByDepartmentSortedByLastNameAscending[header] {
                        ForEach(doctors) { doctor in
                            Button("\(doctor.lastName), \(doctor.firstName)") {
                                router.push(.detail(doctor: doctor))
                            }
                        }
                    }
                }, header: {
                    HStack {
                        HStack {
                            Text("\(header)")
                            Spacer()
                            Text("(\(modelData.doctorsGroupedByDepartmentSortedByLastNameAscending[header]?.count ?? 0))")
                        }
                    }
                })
            }
        }
    }
    
    private var addNewDoctorButton: some View {
        Button("Add New Doctor") {
            presentAddDoctorModal.toggle()
        }
    }
}

#Preview {
    DoctorList()
        .environment(DoctorRouter())
        .environment(ModelData())
}
