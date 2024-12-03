//
//  ContentView.swift
//  SwiftUITemplate
//
//  Created by Gemuele Aludino on 11/27/24.
//

import SwiftUI

struct ContentView: View {
    @State private var selection: TabSelection?

    var body: some View {
        TabView(selection: $selection) {
            ForEach(TabSelection.allCases) { screen in
                screen.navigationStack
                    .tag(screen as TabSelection?)
                    .tabItem { screen.label }
            }
        }
    }
}

#Preview {
    ContentView()
        .environment(ModelData())
}
