//
//  NetworkServiceProtocol.swift
//  SwiftUITemplate
//
//  Created by Gemuele Aludino on 12/3/24.
//

import Foundation

enum ConnectionStatus {
    case idle
    case connecting
    case connected
    case connectedButUnauthenticated
    case authenticated
    case disconnected
}

protocol NetworkServiceProtocol {
    func connect(withCredentials credentials: LoginCredentials) async throws -> (ConnectionStatus, LoginCredentials?)
    func disconnect() async throws -> ConnectionStatus
}
