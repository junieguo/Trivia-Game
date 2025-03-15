//
//  GameView.swift
//  Trivia Game
//
//  Created by Junie Guo on 3/14/25.
//

import SwiftUI

struct GameView: View {
    @Binding var highscore: Int
    @State private var currentQuestionIndex = 0
    @State private var score = 0
    @State private var isGameOver = false
    @State private var questions: [Question]
    
    init(highscore: Binding<Int>) {
        self._highscore = highscore
        self._questions = State(initialValue: [
            Question(text: "Test question", answers: ["1", "2", "3", "4"], correctAnswer: "4"),
        ])
    }

    var body: some View {
        VStack {
            if isGameOver {
                VStack {
                    Text("Game Over")
                        .font(.largeTitle)
                        .fontWeight(.bold)
                        .padding()
                    
                    Text("Your Score: \(score)")
                        .font(.title)
                    
                    if score > highscore {
                        Text("New Highscore!")
                            .foregroundColor(.green)
                            .font(.headline)
                            .padding()
                        // Will update highscore if the player beat it
                    }
                    
                    // Add button to reset game
                    
                    NavigationLink("Back to Home", destination: WelcomeView())
                        .padding()
                }
            } else {
                VStack {
                    Text(questions[currentQuestionIndex].text)
                        .font(.title2)
                        .padding()

                    // Display question image if available
                    if let imageName = questions[currentQuestionIndex].imageName {
                        Image(imageName)
                            .resizable()
                            .scaledToFit()
                            .frame(height: 200)
                            .padding()
                    }

                    // List of answer options as buttons
                    ForEach(questions[currentQuestionIndex].answers, id: \.self) { answer in
                        Button(action: {
                            checkAnswer(selectedAnswer: answer)
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

                    Text("Score: \(score)")
                        .font(.headline)
                        .padding()
                }
            }
        }
        .padding()
        .navigationBarTitle("Trivia Game", displayMode: .inline)
    }
    
    // Check the answer and update score
    private func checkAnswer(selectedAnswer: String) {
        if selectedAnswer == questions[currentQuestionIndex].correctAnswer {
            score += 1
        }
        moveToNextQuestion()
    }

    // Move to the next question
    private func moveToNextQuestion() {
        if currentQuestionIndex + 1 < questions.count {
            currentQuestionIndex += 1
        } else {
            isGameOver = true
        }
    }

    // Reset the game
}

