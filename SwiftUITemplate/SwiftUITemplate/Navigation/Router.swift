//
//  Router.swift
//  SwiftUITemplate
//
//  Created by Gemuele Aludino on 12/2/24.
//

import SwiftUI

protocol Route: Hashable {
    associatedtype DestinationView: View
    associatedtype RootView: View
    
    static var rootView: RootView { get }
    var destination: DestinationView { get }
}

@preconcurrency
protocol RouterProtocol {
    associatedtype V: View
    associatedtype R: Route
    
    var routes: [R] { get }
    
    func navigate(to route: R) -> V

    mutating func push(_ route: R)
    mutating func pop()
    mutating func popToRoot()
}

extension RouterProtocol {
    
    /// Invokes the `destination` property for an `R` (`Route`)
    /// and returns a `View`. Should only be called inside a `NavigationStack`.
    ///
    /// - Parameter route: the `R` (`Route`) that holds the `destination` (`View`)
    /// to be returned
    ///
    /// - Returns: a `View` from an `R` (`Route`)
    @MainActor @ViewBuilder
    func navigate(to route: R) -> some View {
        route.destination
    }
}

@Observable
class Router<T: Route>: @preconcurrency RouterProtocol {
    var routes: [T] = []
    
    var invokeAlert: Bool = false
    
    func push(_ route: T) {
        routes.append(route)
    }
    
    func pop() {
        routes.removeLast()
    }
    
    func popToRoot() {
        routes.removeLast(routes.count)
    }
}
