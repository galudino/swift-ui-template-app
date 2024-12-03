//
//  ContentView.swift
//  SwiftUITemplate
//
//  Created by Gemuele Aludino on 11/27/24.
//

import SwiftUI

struct ContentView: View {
    @State private var selection: TabSelection?
    @State private var loginPresented = true

    var body: some View {
        TabView(selection: $selection) {
            ForEach(TabSelection.allCases) { screen in
                screen.navigationStack
                    .tag(screen as TabSelection?)
                    .tabItem { screen.label }
            }
        }
        .fullScreenCover(isPresented: $loginPresented) {
            // Temporary
            Login(loginPresented: $loginPresented)
                .environment(LoginRouter())
            
            // What we really want to be doing
            // LoginNavigationStack()
        }
    }
}

#Preview {
    ContentView()
        .environment(ModelData())
}
