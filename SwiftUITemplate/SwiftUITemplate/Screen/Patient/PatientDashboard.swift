//
//  PatientDashboard.swift
//  SwiftUITemplate
//
//  Created by Gemuele Aludino on 11/27/24.
//

import SwiftUI

struct PatientDashboard: View {
    @Environment(PatientRouter.self) private var router
    @Environment(ModelData.self) private var modelData
    
    @Environment(\.dismiss) private var dismiss
    
    var body: some View {
        Text("Select an option to begin.")
        
        VStack {
            Button(action: {
                router.push(.list)
            }, label: {
                Text("Patient List")
                    .padding(EdgeInsets(top: 5, leading: 10, bottom: 5, trailing: 10))
                    .frame(maxWidth: .infinity)
            })
            .buttonStyle(.borderedProminent)
            .padding(EdgeInsets(top: 0, leading: 10, bottom: 0, trailing: 10))
        }
        .navigationTitle("Patient Dashboard")
    }
}

#Preview {
    PatientDashboard()
        .environment(PatientRouter())
        .environment(ModelData())
}
