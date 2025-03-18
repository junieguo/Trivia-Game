//
//  ContentView.swift
//  Trivia Game
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        WelcomeView()
    }
}

#Preview {
    ContentView()
        .environmentObject(GameState())
}
