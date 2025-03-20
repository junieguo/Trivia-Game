//
//  GameOverView.swift
//  Trivia Game
//

import SwiftUI

struct GameOverView: View {
    var score: Int
    var isNewHighScore: Bool
    @EnvironmentObject var gameState: GameState

    var body: some View {
        VStack {
            Text("Game Over")
                .font(.largeTitle)
                .fontWeight(.bold)
                .padding()
                .foregroundColor(.red)

            Text("Your Score: \(score)")
                .font(.title)

            if isNewHighScore {
                Text("🎉 New High Score!")
                    .font(.title)
                    .fontWeight(.bold)
                    .foregroundColor(.orange)
                    .padding()
            }

            Button("Restart Game") {
                gameState.goToGame()
            }
            .font(.title)
            .foregroundColor(.white)
            .padding()
            .background(Color.green)
            .cornerRadius(10)
            
            .padding()

            Button("Back to Home") {
                gameState.goHome()
            }
            .font(.title)
            .foregroundColor(.white)
            .padding()
            .background(Color.blue)
            .cornerRadius(10)
        }
        .padding()
        .navigationBarBackButtonHidden(true)
        .navigationBarHidden(true)
    }
}

