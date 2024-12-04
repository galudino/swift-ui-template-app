//
//  ContentView.swift
//  SwiftUITemplate
//
//  Created by Gemuele Aludino on 11/27/24.
//

import SwiftUI
import Observation

struct ContentView: View {
    @Environment(LoginPresentationState.self) private var loginPresentationState
    
    @State private var selection: TabSelection?

    var body: some View {
        if loginPresentationState.tabViewPresented {
            mainTabView
        } else {
            loginNavigationStack
        }
    }
    
    private var mainTabView: some View {
        TabView(selection: $selection) {
            ForEach(TabSelection.allCases) { screen in
                screen.navigationStack
                    .tag(screen as TabSelection?)
                    .tabItem { screen.label }
            }
        }
    }
    
    private var loginNavigationStack: some View {
        @Bindable var loginPresentationState = loginPresentationState
        
        return VStack {
            /// Blank view ensures we do not see the `TabView`
            /// before fully authenticated.
        }
        .fullScreenCover(isPresented: $loginPresentationState.loginPresented) {
            LoginNavigationStack()
        }
    }
}

#Preview {
    ContentView()
        .environment(FakeNetworkService())
        .environment(LoginPresentationState())
        .environment(ModelData(networkService: FakeNetworkService()))
}
