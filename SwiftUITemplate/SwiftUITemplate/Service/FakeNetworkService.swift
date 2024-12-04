//
//  FakeNetworkService.swift
//  SwiftUITemplate
//
//  Created by Gemuele Aludino on 12/3/24.
//

import Observation

@Observable
class FakeNetworkService: NetworkServiceProtocol {
    var status: ConnectionStatus = .idle

    @MainActor
    func connect(withCredentials credentials: LoginCredentials) async throws -> (ConnectionStatus, LoginCredentials?) {
        /// Preparing to connect.
        status = .connecting
        
        /// Simulated attempt to connect to server.
        try await Task.sleep(for: .seconds(0.75))
        status = .connected
        
        /// API would evaluate credentials here.
        guard try await fakeEvaluateCredentials(credentials) else {
            return (.connectedButUnauthenticated, credentials)
        }
        
        status = .authenticated
        
        return (status, credentials)
    }
    
    @MainActor
    func disconnect() async throws -> ConnectionStatus {
        /// Prepare to disconnect. Simulated attempt to disconnect from server.
        try await Task.sleep(for: .seconds(0.75))
        return .idle
    }
    
    @MainActor
    private func fakeEvaluateCredentials(_ credentials: LoginCredentials) async throws -> Bool {
        try await Task.sleep(for: .seconds(0.5))
        /// Only one account/password combination works for this app. It's just a demo!
        return credentials.userName == "Admin" && credentials.password == "1234"
    }
}
