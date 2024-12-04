//
//  Settings.swift
//  SwiftUITemplate
//
//  Created by Gemuele Aludino on 12/3/24.
//

import SwiftUI

struct Settings: View {
    @Environment(FakeNetworkService.self) private var networkService
    @Environment(LoginPresentationState.self) private var loginPresentationState
    @Environment(SettingsRouter.self) private var router
   
    @State private var loggingOut = false
    
    var body: some View {
        VStack {
            if loggingOut {
                HStack {
                    ProgressView()
                    Text("Logging out...")
                }
            } else {
                Text("Click to log out.")
            }
            logOutButton
        }
        .navigationTitle("Settings")
        .onDisappear {
            loginPresentationState.presentLoginFullScreenCover = !loginPresentationState.tabViewVisible
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
                loggingOut = true
                _ = try await networkService.disconnect()
                loginPresentationState.tabViewVisible = false
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
