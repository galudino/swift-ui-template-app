//
//  SwiftUITemplateApp.swift
//  SwiftUITemplate
//
//  Created by Gemuele Aludino on 11/27/24.
//

import SwiftUI

@main
struct SwiftUITemplateApp: App {
    @State private var networkService = FakeNetworkService()
    @State private var authenticationData = LoginPresentationState()
    @State private var modelData = ModelData()
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(networkService)
                .environment(authenticationData)
                .environment(modelData)
        }
    }
}
