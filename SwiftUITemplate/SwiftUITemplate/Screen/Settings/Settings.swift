//
//  Settings.swift
//  SwiftUITemplate
//
//  Created by Gemuele Aludino on 12/3/24.
//

import SwiftUI

struct Settings: View {
    @Environment(FakeNetworkService.self) private var networkService
    @Environment(LoginPresentationState.self) private var authenticationData
    @Environment(SettingsRouter.self) private var router
    
    var body: some View {
        VStack {
            Text("Click to log out.")
            logOutButton
        }
        .navigationTitle("Settings")
        .onDisappear {
            authenticationData.loginPresented = !authenticationData.tabViewPresented
        }
    }
    
    private var logOutButtonLabel: some View {
        HStack {
            HStack {
                Image(systemName: "door.left.hand.open")
                Text("Log Out")
            }
            .padding(EdgeInsets(top: 5, leading: 10, bottom: 5, trailing: 10))
            .frame(maxWidth: .infinity)
        }
    }

    private var logOutButton: some View {
        Button(action: {
            Task { @MainActor in
                try await networkService.disconnect()
                authenticationData.tabViewPresented = false
            }
        }, label: {
            logOutButtonLabel
        })
        .listRowBackground(Rectangle().fill(.clear))
        .buttonStyle(.borderedProminent)
        .padding(EdgeInsets(top: 0, leading: 10, bottom: 0, trailing: 10))
    }
}

#Preview {
    Settings()
        .environment(FakeNetworkService())
        .environment(LoginPresentationState())
        .environment(SettingsRouter())
}
