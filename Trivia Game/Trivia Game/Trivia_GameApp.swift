//
//  Trivia_GameApp.swift
//  Trivia Game
//

import SwiftUI

@main
struct Trivia_GameApp: App {
    @StateObject private var gameState = GameState()

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(gameState)
        }
    }
}
