//
//  Question.swift
//  Trivia Game
//
//  Created by Junie Guo on 3/14/25.
//

import Foundation

struct Question: Identifiable {
    var id = UUID()
    var text: String // The question text
    var imageName: String? // Optional image name associated with the question
    var answers: [String] // The possible answers
    var correctAnswer: String // The correct answer
    
    init(text: String, imageName: String? = nil, answers: [String], correctAnswer: String) {
        self.text = text
        self.imageName = imageName
        self.answers = answers
        self.correctAnswer = correctAnswer
    }
}

