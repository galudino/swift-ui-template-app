//
//  Login.swift
//  SwiftUITemplate
//
//  Created by Gemuele Aludino on 12/3/24.
//

import SwiftUI

struct Login: View {
    @Environment(LoginRouter.self) private var router
    
    @Binding var loginPresented: Bool
    
    @State private var userNameEntered = ""
    @State private var passwordEntered = ""
    
    @State private var showAlert = false
    
    private var allFieldsFilled: Bool {
        !(userNameEntered.isEmpty || passwordEntered.isEmpty)
    }
    
    private var loginCredentials: LoginCredentials {
        LoginCredentials(userName: userNameEntered, password: passwordEntered)
    }
    
    var body: some View {
        VStack {
            VStack {
                Form {
                    textFieldSection
                    confirmLogInButton
                }
            }
        }
        .navigationTitle("Log In")
        .alert("Error", isPresented: $showAlert, actions: {
         
        }, message: {
            Text("Authentication was unsuccessful. Please try again.")
        })
    }
    
    private var textFieldSection: some View {
        Section(content: {
            TextField("User Name", text: $userNameEntered)
            SecureField("Password", text: $passwordEntered)
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
            //router.push(.connecting(credentials: loginCredentials))
            
            if !(loginCredentials.userName == "Admin" && loginCredentials.password == "1234") {
                showAlert = true
                loginPresented = true
            } else {
                loginPresented = false
                showAlert = false
            }
        }, label: {
            confirmLogInLabel
        })
        .buttonStyle(.borderedProminent)
        .listRowBackground(Rectangle().fill(.clear))
        .disabled(!allFieldsFilled)
    }
}

#Preview {
    Login(loginPresented: .constant(false))
        .environment(LoginRouter())
}
