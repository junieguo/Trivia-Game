//
//  GameOverView.swift
//  Trivia Game
//

import SwiftUI

struct GameOverView: View {
    var score: Int
    var isNewHighScore: Bool
    var resetGameAction: () -> Void

    var body: some View {
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
            
            Button(action: resetGameAction) {
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
        }
        .padding()
    }
}


