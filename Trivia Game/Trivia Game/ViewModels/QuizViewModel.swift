//
//  QuizViewModel.swift
//  Trivia Game
//
//  Created by Junie Guo on 3/14/25.
//

import Foundation
import SwiftUI
import Combine

class QuizViewModel: ObservableObject {
    // MARK: - Properties
    @Published var questions: [Question] = [] // Array to store questions
    @Published var currentQuestionIndex: Int = 0 // Index of the current question
    @Published var score: Int = 0 // The user's score
    @Published var highscore: Int = 0 // The user's highscore
    @Published var isGameOver: Bool = false // Flag to check if the game is over
    @Published var timeRemaining: Int = 10 // Time remaining for each question
    @Published var timerRunning: Bool = false // To track if the timer is running

    private var timer: Timer? // Timer for the countdown
    private var timerSubscription: AnyCancellable? // To handle the timer subscription

    // MARK: - Initialization
    init() {
        loadQuestions() // Call to load questions into the array
    }

    // MARK: - Methods

    func loadQuestions() {
        // Hardcoded questions
        self.questions = [
            Question(text: "Test question", answers: ["1", "2", "3", "4"], correctAnswer: "4"),
            Question(text: "Test question", answers: ["4", "3", "2", "1"], correctAnswer: "3")
        ]
    }

    // Start the timer
    func startTimer() {
        timeRemaining = 10 // Reset the time for each question
        timerRunning = true
        timer = Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true) { [weak self] timer in
            guard let self = self else { return }
            if self.timeRemaining > 0 {
                self.timeRemaining -= 1
            } else {
                self.moveToNextQuestion() // Move to the next question when time runs out
            }
        }
    }

    // Stop the timer
    func stopTimer() {
        timer?.invalidate()
        timerRunning = false
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
            startTimer() // Restart timer for the next question
        } else {
            isGameOver = true
            updateHighscore()
            stopTimer()
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
        startTimer() // Restart timer for the first question
    }
}
