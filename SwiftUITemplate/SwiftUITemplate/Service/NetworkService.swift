//
//  NetworkService.swift
//  SwiftUITemplate
//
//  Created by Gemuele Aludino on 12/3/24.
//

import Observation

@Observable
class NetworkService: NetworkServiceProtocol {
    var status: ConnectionStatus = .idle

    @MainActor
    func connect(withCredentials credentials: LoginCredentials) async throws -> (ConnectionStatus, LoginCredentials?) {
        return (.authenticated, credentials)
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
        return true
    }
}
