//
//  QuizViewModel.swift
//  Trivia Game
//

import Foundation
import SwiftUI
import Combine

class QuizViewModel: ObservableObject {
    // MARK: - Properties
    @Published var questions: [Question] = []
    @Published var currentQuestionIndex: Int = 0
    @Published var score: Int = 0
    @Published var isGameOver: Bool = false
    @Published var timeRemaining: Int = 10
    @Published var isNewHighScore: Bool = false // Track if new high score is achieved

    var gameState: GameState
    private var timer: Timer?

    // MARK: - Initialization
    init(gameState: GameState) {
        self.gameState = gameState
        loadQuestions()
    }

    // MARK: - Methods
    func loadQuestions() {
        self.questions = [
            Question(text: "Test question", answers: ["1", "2", "3", "4"], correctAnswer: "4"),
            Question(text: "Test question", answers: ["4", "3", "2", "1"], correctAnswer: "3")
        ]
    }

    // Start the timer
    func startTimer() {
        timeRemaining = 10
        timer = Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true) { [weak self] timer in
            guard let self = self else { return }
            if self.timeRemaining > 0 {
                self.timeRemaining -= 1
            } else {
                self.moveToNextQuestion()
            }
        }
    }

    // Stop the timer
    func stopTimer() {
        timer?.invalidate()
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
            startTimer()
        } else {
            isGameOver = true
            updateHighscore()
            stopTimer()
        }
    }

    func updateHighscore() {
        if score > gameState.highscore {
            gameState.highscore = score
            isNewHighScore = true // Set flag to true
        } else {
            isNewHighScore = false
        }
    }

    func resetGame() {
        score = 0
        currentQuestionIndex = 0
        isGameOver = false
        isNewHighScore = false
        timeRemaining = 10
        loadQuestions()
        startTimer()
    }

}
