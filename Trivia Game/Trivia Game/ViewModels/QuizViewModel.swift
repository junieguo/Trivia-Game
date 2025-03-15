//
//  QuizViewModel.swift
//  Trivia Game
//
//  Created by Junie Guo on 3/14/25.
//

import Foundation
import SwiftUI

class QuizViewModel: ObservableObject { // Conform to ObservableObject
    // MARK: - Properties
    @Published var questions: [Question] = [] // Array to store questions
    @Published var currentQuestionIndex: Int = 0 // Index of the current question
    @Published var score: Int = 0 // The user's score
    @Published var highscore: Int = 0 // The user's highscore
    @Published var isGameOver: Bool = false // Flag to check if the game is over

    // MARK: - Initialization
    init() {
        loadQuestions() // Call to load questions into the array
    }

    // MARK: - Methods

    func loadQuestions() {
        // Hardcoded questions
        self.questions = [
            Question(text: "Test question", answers: ["1", "2", "3", "4"], correctAnswer: "4"),
            Question(text: "Test question", answers: ["1", "2", "3", "4"], correctAnswer: "3")
        ]
    }

    func checkAnswer(selectedAnswer: String) {
        if selectedAnswer == questions[currentQuestionIndex].correctAnswer {
            score += 1
        }
        moveToNextQuestion()
    }

    func moveToNextQuestion() {
        if currentQuestionIndex + 1 < questions.count {
            currentQuestionIndex += 1
        } else {
            isGameOver = true
            updateHighscore()
        }
    }

    func updateHighscore() {
        if score > highscore {
            highscore = score
        }
    }

    func resetGame() {
        score = 0
        currentQuestionIndex = 0
        isGameOver = false
    }
}
