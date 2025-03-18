//
//  GameView.swift
//  Trivia Game
//

import SwiftUI

struct GameView: View {
    @StateObject var viewModel: QuizViewModel

    init(gameState: GameState) {
        _viewModel = StateObject(wrappedValue: QuizViewModel(gameState: gameState))
    }

    var body: some View {
        VStack {
            if viewModel.isGameOver {
                VStack {
                    Text("Game Over")
                        .font(.largeTitle)
                        .fontWeight(.bold)
                        .padding()
                    
                    Text("Your Score: \(viewModel.score)")
                        .font(.title)
                    
                    if viewModel.isNewHighScore {
                        Text("New High Score!")
                            .font(.title)
                            .fontWeight(.bold)
                            .foregroundColor(.orange)
                            .padding()
                    }
                    
                    Button(action: {
                        viewModel.resetGame()
                    }) {
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
            } else {
                VStack {
                    Text(viewModel.questions[viewModel.currentQuestionIndex].text)
                        .font(.title2)
                        .padding()

                    if let imageName = viewModel.questions[viewModel.currentQuestionIndex].imageName {
                        Image(imageName)
                            .resizable()
                            .scaledToFit()
                            .frame(height: 200)
                            .padding()
                    }

                    Text("Time Remaining: \(viewModel.timeRemaining)")
                        .font(.headline)
                        .padding()

                    ForEach(viewModel.questions[viewModel.currentQuestionIndex].answers, id: \.self) { answer in
                        Button(action: {
                            viewModel.checkAnswer(selectedAnswer: answer)
                        }) {
                            Text(answer)
                                .font(.title)
                                .padding()
                                .background(Color.blue)
                                .foregroundColor(.white)
                                .cornerRadius(10)
                                .padding(5)
                        }
                    }

                    Text("Score: \(viewModel.score)")
                        .font(.headline)
                        .padding()
                }
            }
        }
        .padding()
        .navigationBarTitle("Trivia Game", displayMode: .inline)
        .onAppear {
            viewModel.startTimer()
        }
        .onDisappear {
            viewModel.stopTimer()
        }
    }
}
