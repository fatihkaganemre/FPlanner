//
//  TrainingViewModel.swift
//  FPlanner
//
//  Created by Fatih Kagan Emre on 04/06/2024.
//

import SwiftUI
import SwiftData

@MainActor
class TrainingViewModel: ObservableObject {
    @Published var trainingName: String
    @Published var customExercises: [CustomExercise]
    @Published var gymExercises: [GymExercise]
    private let training: Training
    
    let trainingType: TrainingType

    var buttonTitle: String {
        isCreateTraining ? "Create": "Save"
    }
    
    var navigationTitle: String {
         "\(training.type == .gym ? "Gym" : "Custom") training"
    }
    
    var isExerciseListEmpty: Bool {
        customExercises.isEmpty && gymExercises.isEmpty
    }
    
    var isCreateTraining: Bool {
        training.name == nil
    }
    
    init(training: Training) {
        self.training = training
        self.trainingName = training.name ?? ""
        self.customExercises = training.customExercises
        self.gymExercises = training.gymExercises
        self.trainingType = training.type
    }
    
    func saveOrDeleteTraining(fromContext modelContext: ModelContext) {
        isCreateTraining
        ? createTraining(modelContext: modelContext)
        : saveTraining()
    }
    
    private func createTraining(modelContext: ModelContext) {
        let newTraining = Training(
            name: trainingName,
            gymExercises: gymExercises,
            customExercises: customExercises,
            type: training.type
        )
        modelContext.insert(newTraining)
    }
    
    private func saveTraining() {
        training.name = trainingName
        switch training.type {
        case .gym: training.gymExercises = gymExercises
        case .custom: training.customExercises = customExercises
        }
    }
}
