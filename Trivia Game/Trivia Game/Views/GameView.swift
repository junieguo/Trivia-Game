//
//  GameView.swift
//  Trivia Game
//

import SwiftUI

struct GameView: View {
    @StateObject var viewModel: QuizViewModel
    @EnvironmentObject var gameState: GameState

    init(gameState: GameState) {
        _viewModel = StateObject(wrappedValue: QuizViewModel(gameState: gameState))
    }

    var body: some View {
        ZStack {
            VStack {
                Text(viewModel.questions[viewModel.currentQuestionIndex].text)
                    .font(.title2)
                    .padding()

                let imageName = viewModel.questions[viewModel.currentQuestionIndex].imageName
                Image(imageName)
                    .resizable()
                    .scaledToFit()
                    .frame(height: 180)
                    .padding()

                ForEach(viewModel.questions[viewModel.currentQuestionIndex].answers, id: \.self) { answer in
                    Button(action: {
                        viewModel.checkAnswer(selectedAnswer: answer)
                    }) {
                        Text(answer)
                            .font(.title)
                            .padding()
                            .frame(maxWidth: 250)
                            .background(Color.blue)
                            .foregroundColor(.white)
                            .cornerRadius(10)
                            .padding(5)
                    }
                }
            }
            .padding(.top, 50)

            VStack {
                HStack {
                    Text("Time Remaining: \(viewModel.timeRemaining)")
                        .font(.headline)
                        .padding()
                        .foregroundColor(viewModel.timeRemaining <= 3 ? .red : .black)
                    Spacer()
                    Text("Score: \(viewModel.score)")
                        .font(.headline)
                        .padding()
                }
                .padding(.top)
                Spacer()
            }
            .zIndex(1)

            HStack {
                Spacer()
                VStack {
                    Spacer()
                    Button(action: {
                        gameState.goHome()
                    }) {
                        Image(systemName: "house.fill")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 40, height: 40)
                            .font(.title)
                            .foregroundColor(.blue)
                    }
                    .padding(.bottom, 20)
                    .padding(.horizontal, 20)
                }
            }
        }
        .onAppear {
            if !viewModel.isGameOver {
                viewModel.startTimer()
            }
        }
        .onDisappear {
            viewModel.stopTimer()
        }
        .background(
            NavigationLink(
                destination: GameOverView(score: viewModel.score, isNewHighScore: viewModel.isNewHighScore)
                    .environmentObject(viewModel.gameState),
                isActive: $viewModel.isGameOver
            ) {
                EmptyView()
            }
        )
        .navigationBarHidden(true)
        .navigationBarBackButtonHidden(true)
    }
}

