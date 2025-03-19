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
            Question(text: "What is the symbol for the Euro?", imageName: "Euro", answers: ["£", "€", "¥", "₹"], correctAnswer: "€"),
            Question(text: "The 'Baht' is the currency of which country?", imageName: "Baht", answers: ["Thailand", "Laos", "Myanmar", "Cambodia"], correctAnswer: "Thailand"),
            Question(text: "Which country uses the 'Sol' as its currency?", imageName: "Sol", answers: ["Peru", "Ecuador", "Chile", "Colombia"], correctAnswer: "Peru"),
            Question(text: "Which country uses the 'Kwanza' as its official currency?", imageName: "Kwanza", answers: ["Angola", "Mozambique", "Ghana", "Zambia"], correctAnswer: "Angola"),
            Question(text: "Which of these countries does not use the Euro despite being part of the European Union?", imageName: "EuropeanUnion", answers: ["Germany", "Austria", "Sweden", "Portugal"], correctAnswer: "Sweden"),
            Question(text: "Which of these countries’ official currency is called 'Pound,' but it is not the British Pound?", imageName: "Pound", answers: ["Egypt", "United Kingdom", "South Africa", "Jordan"], correctAnswer: "Egypt"),
            Question(text: "Which country uses the 'Rupee,' but the currency’s value is among the highest in the world?", imageName: "Rupee", answers: ["India", "Pakistan", "Sri Lanka", "Seychelles"], correctAnswer: "Seychelles"),
            Question(text: "What is the world’s oldest still-existing currency?", imageName: "OldCurrencies", answers: ["Chinese Yuan", "British Pound", "Japanese Yen", "Swiss Franc"], correctAnswer: "British Pound"),
            Question(text: "What is the most widely-used currency in the world?", imageName: "CommonCurrencies", answers: ["Euro", "Chinese Yuan", "US Dollar", "Japanese Yen"], correctAnswer: "US Dollar"),
            Question(text: "Which of the following countries does not use the Peso as its currency?", imageName: "Peso", answers: ["Mexico", "Argentina", "Chile", "Brazil"], correctAnswer: "Brazil")
        ]
        self.questions.shuffle()
    }

    // Start the timer
    func startTimer() {
        stopTimer()
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
