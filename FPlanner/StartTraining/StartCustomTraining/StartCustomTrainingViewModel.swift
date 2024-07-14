//
//  StartCustomTrainingViewModel.swift
//  FPlanner
//
//  Created by Fatih Kagan Emre on 08/07/2024.
//

import SwiftUI

@MainActor
class StartCustomTrainingViewModel: ObservableObject {
    var exercises: [CustomExercise]
    @Published var index: Int = 0
    @Published var buttonState: ButtonState = .Next
    
    init(exercises: [CustomExercise]) {
        self.exercises = exercises
        
        if exercises.count == 1 {
            buttonState = .Finish
        }
    }
    
    enum ButtonState: String {
        case Next, Finish
    }
    
    func nextExercise() {
        if index < exercises.count - 1 {
            index += 1
        }
        
        if index == exercises.count - 1 {
            buttonState = .Finish
        }
    }
    
    func handleBackButtonAction() {
        if index > 0 {
            index -= 1
        }
        
        if buttonState == .Finish {
            buttonState = .Next
        }
    }
}
