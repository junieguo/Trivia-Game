//
//  Trivia_GameApp.swift
//  Trivia Game
//
//  Created by Junie Guo on 3/13/25.
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
