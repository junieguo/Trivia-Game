//
//  GameView.swift
//  Trivia Game
//
//  Created by Junie Guo on 3/14/25.
//

import SwiftUI

struct GameView: View {
    @StateObject var viewModel = QuizViewModel() // ViewModel instance
    @Binding var highscore: Int // Binding to update highscore
    
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
                    
                    // Update the highscore when score is greater than current highscore
                    if viewModel.score > highscore {
                        Text("New Highscore!")
                            .foregroundColor(.green)
                            .font(.headline)
                            .padding()
                    }
                    
                    // Button to reset game
                    Button(action: {
                        // Update the highscore after game over
                        if viewModel.score > highscore {
                            highscore = viewModel.score // Update the highscore in the parent view
                        }
                        viewModel.resetGame() // Reset the game
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
                        .padding() //bug, resets high score
                }
            } else {
                VStack {
                    Text(viewModel.questions[viewModel.currentQuestionIndex].text)
                        .font(.title2)
                        .padding()

                    // Display question image if available
                    if let imageName = viewModel.questions[viewModel.currentQuestionIndex].imageName {
                        Image(imageName)
                            .resizable()
                            .scaledToFit()
                            .frame(height: 200)
                            .padding()
                    }
                    
                    // Display Timer
                    Text("Time Remaining: \(viewModel.timeRemaining)")
                        .font(.headline)
                        .padding()
                                        

                    // List of answer options as buttons
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
            viewModel.startTimer() // Start the timer when the view appears
        }
        .onDisappear {
            viewModel.stopTimer() // Stop timer when the view disappears
        }
    }
}
