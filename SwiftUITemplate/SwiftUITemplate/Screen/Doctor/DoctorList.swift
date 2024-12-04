//
//  DoctorList.swift
//  SwiftUITemplate
//
//  Created by Gemuele Aludino on 11/27/24.
//

import SwiftUI

struct DoctorList: View {
    @Environment(FakeNetworkService.self) private var networkService
    @Environment(DoctorRouter.self) private var router
    @Environment(ModelData.self) private var modelData
    
    @State private var presentAddDoctorSheet = false
    
    @State private var isLoading = false
    @State private var isRefreshing = false
    
    @State private var doLoad = true

    var body: some View {
        VStack {
            if isLoading && !isRefreshing {
                ProgressView()
                Text("Please wait...")
            } else {
                doctorList
            }
        }
        .navigationTitle("Doctor List")
        .toolbar {
            ToolbarItem(placement: .topBarTrailing) {
                addNewDoctorButton
            }
        }
        .onAppear {
            if doLoad {
                Task { @MainActor in
                    isLoading = true
                    modelData.doctors = try await networkService.fetchDoctors()
                    modelData.doctors.sort(by: { $0.lastName < $1.lastName })
                    isLoading = false
                }
            }
        }
        .refreshable {
            Task { @MainActor in
                isLoading = true
                isRefreshing = true
                
                modelData.doctors = try await networkService.fetchDoctors()
                modelData.doctors.sort(by: { $0.lastName < $1.lastName })
               
                isRefreshing = false
                isLoading = false
            }
        }
        .sheet(isPresented: $presentAddDoctorSheet) {
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
                                /// Ensures we don't load again when navigating back
                                doLoad = false
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
            presentAddDoctorSheet.toggle()
        }
    }
}

#Preview {
    DoctorList()
        .environment(FakeNetworkService())
        .environment(DoctorRouter())
        .environment(ModelData(networkService: FakeNetworkService()))
}
