//
//  Connecting.swift
//  SwiftUITemplate
//
//  Created by Gemuele Aludino on 12/3/24.
//

import Foundation
import SwiftUI

struct Connecting: View {
    @Environment(LoginRouter.self) private var router
    @Environment(\.dismiss) private var dismiss
    
    var credentials: LoginCredentials
    
    var body: some View {
        VStack {
            Text("Please wait...")
            cancelButton
        }
        .navigationTitle("Connecting...")
        .navigationBarBackButtonHidden()
        .onAppear {
            // Check credentials here
            DispatchQueue.main.asyncAfter(deadline: DispatchTime(uptimeNanoseconds: 100000)) {
                
            }
        }
    }
    
    private var cancelButton: some View {
        Button(action: {
            //router.pop()
        }, label: {
            Text("Cancel")
                .padding(EdgeInsets(top: 10, leading: 20, bottom: 10, trailing: 20))
                .frame(maxWidth: .infinity)
        })
        .padding(EdgeInsets(top: 0, leading: 20, bottom: 0, trailing: 20))
        .buttonStyle(.bordered)
    }
}

#Preview {
    Connecting(credentials: LoginCredentials(userName: "John Doe", password: "password"))
        .environment(LoginRouter())
}
