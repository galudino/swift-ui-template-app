//
//  RouterProtocol.swift
//  SwiftUITemplate
//
//  Created by Gemuele Aludino on 12/2/24.
//

import SwiftUI

@preconcurrency
protocol Router {
    associatedtype V: View
    associatedtype R: Route
    
    var routes: [R] { get }
    
    func navigate(to route: R) -> V

    mutating func push(_ route: R)
    mutating func pop()
    mutating func popToRoot()
}

extension Router {
    @MainActor
    @ViewBuilder
    func navigate(to route: R) -> some View {
        route.destination
    }
}
