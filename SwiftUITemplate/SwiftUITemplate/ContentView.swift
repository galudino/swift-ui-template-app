//
//  ContentView.swift
//  SwiftUITemplate
//
//  Created by Gemuele Aludino on 11/27/24.
//

import Observation
import SwiftUI

struct ContentView: View {
    @Environment(LoginPresentationState.self) private var loginPresentationState

    @State private var selection: TabSelection?
    
    var body: some View {
        if loginPresentationState.tabViewVisible {
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
        
        return VStack { }
            .fullScreenCover(isPresented: $loginPresentationState.presentLoginFullScreenCover) {
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
