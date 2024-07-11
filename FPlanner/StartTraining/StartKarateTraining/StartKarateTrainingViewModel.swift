//
//  StartKarateTrainingViewModel.swift
//  FPlanner
//
//  Created by Fatih Kagan Emre on 08/07/2024.
//

import SwiftUI
import Combine

@MainActor
class StartKarateTrainingViewModel: ObservableObject {
    @Published var timerSubscription: Cancellable?
    @Published var timer = Timer.publish(every: 1, on: .main, in: .common)
    @Published var index: Int = 0
    @Published var buttonState: ButtonState = .Start
    @Published var timeRemaining: Int = 0
    @Published var trimTo = 0.0
    var exercises: [KarateExercise]
    
    init(exercises: [KarateExercise]) {
        self.exercises = exercises
    }
    
    enum ButtonState: String {
        case Start
        case Pause
        case Play
        case Finish
    }
    
    // MARK: - Timer
    
    private func startTimer() {
        timer = Timer.publish(every: 1, on: .main, in: .common)
        timerSubscription = timer.connect()
    }
    
    private func cancelTimer() {
        timerSubscription?.cancel()
        timerSubscription = nil
    }
    
    
    // MARK: - Button Actions:
    
    func handleMainButtonAction() {
        switch buttonState {
            case .Start:
                startTimer()
                buttonState = .Pause
            case .Pause:
                cancelTimer()
                buttonState = .Play
            case .Play:
                startTimer()
                buttonState = .Pause
            default: break
        }
    }
    
    func handleSkipButtonAction() {
        cancelTimer()
        nextExercise()
    }
    
    func handleBackButtonAction() {
        cancelTimer()
        previousExercise()
    }
    
    // MARK: - Helper functions
    
    func setRemainingTimeOnAppear() {
        timeRemaining = exercises[0].durationInSec ?? 0
    }
    
    func timerUpdate() {
        if timeRemaining > 0 {
            timeRemaining -= 1
            let totalTime = Double(exercises[index].durationInSec ?? 0)
            trimTo = 1 - (Double(timeRemaining) / totalTime)
        } else {
            nextExercise()
        }
    }
    
    private func nextExercise() {
        guard index < exercises.count - 1 else {
            buttonState = .Finish
            return
        }
        index += 1
        timeRemaining = exercises[index].durationInSec ?? 0
        let totalTime = Double(exercises[index].durationInSec ?? 0)
        trimTo = 1 - (Double(timeRemaining) / totalTime)
        cancelTimer()
        buttonState = .Start
    }
    
    private func previousExercise() {
        guard index > 0 else { return }
        index -= 1
        timeRemaining = exercises[index].durationInSec ?? 0
        let totalTime = Double(exercises[index].durationInSec ?? 0)
        trimTo = 1 - (Double(timeRemaining) / totalTime)
        buttonState = .Start
    }
}
