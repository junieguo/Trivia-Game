//
//  WelcomeView.swift
//  Trivia Game
//

import SwiftUI

struct WelcomeView: View {
    @EnvironmentObject var gameState: GameState
    @State private var showInstructions = false
    
    var body: some View {
        NavigationStack(path: $gameState.navigationPath) {
            VStack(spacing: 20) {
                
                Text("World Currency Trivia")
                    .font(.largeTitle)
                    .fontWeight(.bold)
                
                Image("WorldCurrencies")
                    .resizable()
                    .frame(width: 400, height: 200)
                
                Text("Test your knowledge of currencies around the world with a series of trivia questions.")
                    .font(.title3)
                    .padding(.horizontal)
                
                Spacer().frame(height: 15)
                
                HStack {
                    Text("🏆 Highscore:")
                        .font(.title2)
                        .fontWeight(.bold)
                        .foregroundColor(.blue)
                    
                    Text("\(gameState.highscore)")
                        .font(.title2)
                        .fontWeight(.semibold)
                        .foregroundColor(.green)
                }
                .padding(.horizontal)
                
                HStack {
                    Button(action: {
                        gameState.goToGame()
                    }) {
                        Text("Start Quiz")
                            .font(.title2)
                            .fontWeight(.bold)
                            .foregroundColor(.white)
                            .padding()
                            .frame(maxWidth: .infinity)
                            .background(
                                LinearGradient(gradient: Gradient(colors: [Color.blue, Color.purple]), startPoint: .leading, endPoint: .trailing)
                            )
                            .cornerRadius(15)
                    }

                    Button(action: {
                        showInstructions.toggle()
                    }) {
                        Image(systemName: "info.circle")
                            .font(.title)
                            .foregroundColor(.blue)
                    }
                    .padding(.leading, 5)
                }
                .padding()
            }
            .navigationBarHidden(true)
            .navigationBarBackButtonHidden(true)
            .navigationDestination(for: String.self) { value in
                if value == "GameView" {
                    GameView(gameState: gameState)
                }
            }
            .sheet(isPresented: $showInstructions) {
                InstructionsView(showInstructions: $showInstructions)
            }
        }
    }
}

struct InstructionsView: View {
    @Binding var showInstructions: Bool

    var body: some View {
        VStack {
            Text("Instructions")
                .font(.largeTitle)
                .fontWeight(.bold)
                .padding()

            Text("In this trivia game, you will be asked questions related to world currencies. Choose the correct answer from multiple choices before time runs out. Each correctly answered question adds a point to the score. Try to get the highest score possible!")
                .font(.body)
                .padding()

            Button("Close") {
                showInstructions = false
            }
            .font(.title)
            .foregroundColor(.white)
            .padding()
            .background(Color.blue)
            .cornerRadius(10)
            .padding()
        }
    }
}

