//
//  GameState.swift
//  Trivia Game
//

import Foundation
import SwiftUI

class GameState: ObservableObject {
    @Published var highscore: Int = 0
    @Published var navigationPath = NavigationPath()

    func goToGame() {
        navigationPath.append("GameView")
    }
    
    func goHome() {
        navigationPath = NavigationPath()
    }
}
