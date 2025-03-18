//
//  WelcomeView.swift
//  Trivia Game
//

import SwiftUI

struct WelcomeView: View {
    @EnvironmentObject var gameState: GameState // Access the global game state

    var body: some View {
        NavigationStack {
            VStack {
                Text("World Currency Trivia")
                    .font(.largeTitle)
                    .fontWeight(.bold)
                    .padding()

                Text("Test your knowledge of currencies around the world with a series of trivia questions.")
                    .font(.title2)
                    .padding()

                Text("Highscore: \(gameState.highscore)")
                    .font(.headline)
                    .padding()

                NavigationLink(destination: GameView(gameState: gameState)) {
                    Text("Start Quiz")
                        .font(.title)
                        .foregroundColor(.white)
                        .padding()
                        .background(Color.blue)
                        .cornerRadius(10)
                }
                .padding()
            }
            .navigationBarTitle("Trivia Game", displayMode: .inline)
        }
    }
}
