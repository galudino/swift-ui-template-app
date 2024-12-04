//
//  Connecting.swift
//  SwiftUITemplate
//
//  Created by Gemuele Aludino on 12/3/24.
//

import Foundation
import SwiftUI

// MARK: - ConnectingState

enum ConnectingState {
    case idle
    case connecting
    case successful
    case error
}

// MARK: - Connecting

struct Connecting: View {
    @Environment(FakeNetworkService.self) private var networkService
    @Environment(LoginPresentationState.self) private var loginPresentationState
    @Environment(LoginRouter.self) private var router

    @Environment(\.dismiss) private var dismiss

    @State private var statusLabelText: String = ""

    @State private var showAlert = false
    @State private var connectingState: ConnectingState = .idle {
        didSet {
            switch connectingState {
            case .idle:
                statusLabelText = "On standby."
                showAlert = false
            case .connecting:
                statusLabelText = "Connecting. Please wait..."
                showAlert = false
            case .successful:
                statusLabelText = "Authentication successful!"
                showAlert = false

                loginPresentationState.loginPresented = false
            case .error:
                statusLabelText = "Error occurred."
                showAlert = true

                loginPresentationState.loginPresented = true
                loginPresentationState.tabViewPresented = false
            }
        }
    }

    private let enteredLoginCredentials: LoginCredentials

    init(credentials: LoginCredentials) {
        enteredLoginCredentials = credentials
    }

    var body: some View {
        VStack {
            ProgressView()
            Text(statusLabelText)
            cancelButton
        }
        .navigationTitle("Connecting...")
        .navigationBarBackButtonHidden()
        .onAppear {
            @Bindable var loginPresentationState = loginPresentationState

            connectingState = .connecting

            Task { @MainActor in
                let (status, credentials) = try await networkService.connect(withCredentials: enteredLoginCredentials)

                if status == .authenticated, let credentials {
                    connectingState = .successful
                    loginPresentationState.credentials = credentials
                } else if status == .connectedButUnauthenticated {
                    connectingState = .error
                }
            }
        }
        .onDisappear {
            loginPresentationState.tabViewPresented = connectingState == .successful
        }
        .alert("Error", isPresented: $showAlert, actions: {
            Button("OK") {
                router.pop()
            }
        }, message: {
            Text("Authentication was unsuccessful. Please try again.")
        })
    }

    private var cancelButton: some View {
        Button(action: {
            router.pop()
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
    Connecting(credentials: LoginCredentials.previews[0])
        .environment(FakeNetworkService())
        .environment(LoginPresentationState())
        .environment(LoginRouter())
}
