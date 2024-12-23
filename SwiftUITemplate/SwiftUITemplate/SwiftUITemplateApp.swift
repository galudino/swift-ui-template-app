//
//  SwiftUITemplateApp.swift
//  SwiftUITemplate
//
//  Created by Gemuele Aludino on 11/27/24.
//

import SwiftUI

@main
struct SwiftUITemplateApp: App {
    @State private var networkService: FakeNetworkService
    @State private var loginPresentationState: LoginPresentationState
    @State private var modelData: ModelData
    
    init() {
        let networkService = FakeNetworkService()
        
        self.networkService = networkService
        loginPresentationState = LoginPresentationState()
        modelData = ModelData(networkService: networkService)
    }
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(networkService)
                .environment(loginPresentationState)
                .environment(modelData)
        }
    }
}

