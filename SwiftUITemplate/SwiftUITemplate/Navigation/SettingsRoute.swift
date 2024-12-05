//
//  SettingsRoute.swift
//  SwiftUITemplate
//
//  Created by Gemuele Aludino on 12/3/24.
//

import SwiftUI

enum SettingsRoute: @preconcurrency Route, Hashable {
    case settings
    
    @MainActor
    @ViewBuilder
    static var rootView: some View {
        Settings()
    }

    @MainActor
    @ViewBuilder
    var destination: some View {
        switch self {
        case .settings:
            Settings()
        }
    }
}
