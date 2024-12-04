//
//  Login.swift
//  SwiftUITemplate
//
//  Created by Gemuele Aludino on 12/3/24.
//

import SwiftUI

struct Login: View {
    @Environment(LoginRouter.self) private var router

    @State private var enteredUserName = ""
    @State private var enteredPassword = ""

    @State private var showAlert = false
    
    var body: some View {
        Form {
            textFieldSection
            confirmLogInButton
        }
        .navigationTitle("Log In")
        .alert("Error", isPresented: $showAlert, actions: {}, message: {
            Text("Authentication was unsuccessful. Please try again.")
        })
    }
    
    private var allFieldsFilled: Bool {
        !(enteredUserName.isEmpty || enteredPassword.isEmpty)
    }

    private var textFieldSection: some View {
        return Section(content: {
            TextField("User Name", text: $enteredUserName)
            SecureField("Password", text: $enteredPassword)
        }, header: {
            Text("Credentials")
        }, footer: {
            Text("User Name is 'Admin' and Password is '1234'.")
        })
    }

    private var confirmLogInLabel: some View {
        HStack {
            HStack {
                Text("Log In")
            }
            .padding(EdgeInsets(top: 5, leading: 5, bottom: 5, trailing: 5))
            .frame(maxWidth: .infinity)
        }
    }

    private var confirmLogInButton: some View {
        Button(action: {
                   router.push(.connecting(
                       loginCredentials: LoginCredentials(
                           userName: enteredUserName,
                           password: enteredPassword
                       )))
               },
               label: {
                   confirmLogInLabel
               })
               .buttonStyle(.borderedProminent)
               .listRowBackground(Rectangle().fill(.clear))
               .disabled(!allFieldsFilled)
    }
}

#Preview {
    Login()
        .environment(LoginRouter())
}
