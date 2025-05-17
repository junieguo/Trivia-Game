# World Currency Trivia Game

This is an educational and fun quiz iOS app built with SwiftUI. The game challenges players with multiple-choice questions about currencies from around the world.

---

## Features

- 🎯 **10 Currency-Themed Questions** per session  
- ⏱ **10-Second Timer** per question (automatically advances if time runs out)  
- 🧠 **Score Tracking** and immediate feedback  
- 🏆 **High Score Display** on Welcome Screen  
- 🔁 **Game Reset** anytime during or after gameplay  
- 🖼 **Custom Images** for each question  
- 📱 **MVVM Architecture** with `@Observable` ViewModel and structured model  
- 📐 **Adaptive Design** for light/dark modes using SwiftUI

---

## Screens

- **Welcome View**
  - App title, brief instructions, high score display
  - "Start Quiz" button navigates to GameView
  - Info button opens a modal with gameplay instructions

- **Game View**
  - Shows one question at a time with an image and 4 answers
  - Countdown timer and score display
  - Tap answer to proceed or auto-advance on timeout
  - Back-to-home button available

- **Game Over View**
  - Final score summary
  - New high score alert (if applicable)
  - Options to restart the game or return home

---

## Architecture

- **Models**
  - `Question`: Represents a single trivia question with text, image, choices, and correct answer.

- **ViewModels**
  - `GameState`: Manages high score and navigation path using `NavigationStack`.
  - `QuizViewModel`: Handles game logic, question flow, score, and timer.

- **Views**
  - `WelcomeView`, `GameView`, `GameOverView`, `InstructionsView`

- **State Management**
  - Uses `@StateObject`, `@EnvironmentObject`, and `@Published` for reactive data flow.
  - Timer runs via `Timer.scheduledTimer` and stops/resets appropriately.

---

## How to Run

1. Open `WorldCurrencyTrivia.xcodeproj` in **Xcode 15** on **macOS Ventura** or later.
2. Build and run the app on a simulator or physical device (iOS 16+).
3. Tap **Start Quiz** to begin.
4. Answer questions before the 10-second timer ends.
5. View your score, check if you beat your high score, and replay instantly.

---

## Notes

- Data (high score) is stored in-memory for the session; not persisted between app launches.
- Game reset clears all progress and starts a fresh session.
