//
//  FakeNetworkService.swift
//  SwiftUITemplate
//
//  Created by Gemuele Aludino on 12/3/24.
//

import Foundation
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
        /// Only one account/password combination works for this app. It's just a demo!
        let validCredentials = LoginCredentials(userName: "Admin", password: "1234")
        return credentials == validCredentials
    }
}

extension FakeNetworkService {
    @MainActor
    func fetchDoctors() async throws -> [Doctor] {
        try await Task.sleep(for: .seconds(0.5))
        return load("doctors.json")
    }
    
    @MainActor
    func fetchPatients() async throws -> [Patient] {
        try await Task.sleep(for: .seconds(0.5))
        return load("patients.json")
    }
}

fileprivate func load<T: Decodable>(_ filename: String) -> T {
    let data: Data

    guard let file = Bundle.main.url(forResource: filename, withExtension: nil)
    else {
        fatalError("Couldn't find \(filename) in main bundle.")
    }

    do {
        data = try Data(contentsOf: file)
    } catch {
        fatalError("Couldn't load \(filename) from main bundle:\n\(error)")
    }

    do {
        let decoder = JSONDecoder()
        return try decoder.decode(T.self, from: data)
    } catch {
        fatalError("Couldn't parse \(filename) as \(T.self):\n\(error)")
    }
}
