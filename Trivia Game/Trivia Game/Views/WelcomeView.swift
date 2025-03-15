//
//  WelcomeView.swift
//  Trivia Game
//
//  Created by Junie Guo on 3/14/25.
//

import SwiftUI

struct WelcomeView: View {
    @State private var isGameStarted = false
    @State private var highscore = 0 // Placeholder for highscore

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

                Text("Highscore: \(highscore)")
                    .font(.headline)
                    .padding()

                NavigationLink(destination: GameView(highscore: $highscore)) {
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

#Preview {
    WelcomeView()
}

