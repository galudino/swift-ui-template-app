//
//  DoctorDashboard.swift
//  SwiftUITemplate
//
//  Created by Gemuele Aludino on 11/27/24.
//

import SwiftUI

struct DoctorDashboard: View {
    @Environment(FakeNetworkService.self) private var networkService
    @Environment(Router<DoctorRoute>.self) private var router
    @Environment(ModelData.self) private var modelData

    var body: some View {
        Text("Select an option to begin.")

        VStack {
            Button(action: {
                router.push(.list)
            }, label: {
                HStack {
                    Image(systemName: "list.bullet")
                    Text("Doctor List")
                }
                .padding(EdgeInsets(top: 5, leading: 10, bottom: 5, trailing: 10))
                .frame(maxWidth: .infinity)
            })
            .buttonStyle(.borderedProminent)
            .padding(EdgeInsets(top: 0, leading: 10, bottom: 0, trailing: 10))
        }
        .navigationTitle("Doctor Dashboard")
    }
}

#Preview {
    DoctorDashboard()
        .environment(FakeNetworkService())
        .environment(Router<DoctorRoute>())
        .environment(ModelData(networkService: FakeNetworkService()))
}
