//
//  Question.swift
//  Trivia Game
//

import Foundation

struct Question: Identifiable {
    var id = UUID()
    var text: String // The question text
    var imageName: String
    var answers: [String] // The possible answers
    var correctAnswer: String // The correct answer
}

