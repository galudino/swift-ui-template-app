//
//  Route.swift
//  SwiftUITemplate
//
//  Created by Gemuele Aludino on 12/2/24.
//

import SwiftUI

protocol Route: Hashable {
    associatedtype V: View
    var destination: V { get }
}
