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
        NavigationStack {
            VStack {
                Text("Game Over")
                    .font(.largeTitle)
                    .fontWeight(.bold)
                    .padding()
                
                Text("Your Score: \(score)")
                    .font(.title)
                
                if isNewHighScore {
                    Text("New High Score!")
                        .font(.title)
                        .fontWeight(.bold)
                        .foregroundColor(.orange)
                        .padding()
                }
                
                NavigationLink(destination: GameView(gameState: gameState)) {
                    Text("Restart Game")
                        .font(.title)
                        .foregroundColor(.white)
                        .padding()
                        .background(Color.green)
                        .cornerRadius(10)
                }
                .padding()

                NavigationLink("Back to Home", destination: WelcomeView())
                    .padding()
                    .navigationBarHidden(true)
                    .navigationBarBackButtonHidden(true)
            }
            .padding()
            .navigationBarHidden(true)
            .navigationBarBackButtonHidden(true)
        }
    }
}
