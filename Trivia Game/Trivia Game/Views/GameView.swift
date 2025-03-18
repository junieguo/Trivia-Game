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
        NavigationView {
            ZStack {
                VStack {
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
                    }
                    .padding(.top, 50)
                }

                VStack {
                    HStack {
                        Text("Time Remaining: \(viewModel.timeRemaining)")
                            .font(.headline)
                            .padding()
                        Spacer()
                        Text("Score: \(viewModel.score)")
                            .font(.headline)
                            .padding()
                    }
                    .padding(.top)
                    Spacer()
                }
                .zIndex(1)
            }
            .onAppear {
                viewModel.startTimer()
            }
            .onDisappear {
                viewModel.stopTimer()
            }
            .background(
                NavigationLink(
                    destination: GameOverView(score: viewModel.score, isNewHighScore: viewModel.isNewHighScore)
                        .environmentObject(viewModel.gameState),
                    isActive: $viewModel.isGameOver
                )  {
                    EmptyView()
                }
            )
        }
        .navigationBarHidden(true)
        .navigationBarBackButtonHidden(true)
    }
}

#Preview {
    GameView(gameState: GameState())
        .environmentObject(GameState())
}
