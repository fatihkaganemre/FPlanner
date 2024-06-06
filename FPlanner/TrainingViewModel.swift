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
    @Published var karateExercises: [KarateExercise]
    @Published var scheduledAt: Date
    private let training: Training
    
    let trainingType: TrainingType

    var buttonTitle: String {
        isCreateTraining ? "Create": "Save"
    }
    
    var navigationTitle: String {
        switch trainingType {
            case .gym: return "Gym training"
            case .karate: return "Karate training"
            case .custom: return "Custom training"
        }
    }
    
    var isExerciseListEmpty: Bool {
        customExercises.isEmpty
        && gymExercises.isEmpty
        && karateExercises.isEmpty
    }
    
    var isCreateTraining: Bool {
        training.name == nil
    }
    
    init(training: Training) {
        self.training = training
        self.trainingName = training.name ?? ""
        self.customExercises = training.customExercises
        self.gymExercises = training.gymExercises
        self.karateExercises = training.karateExercises
        self.trainingType = training.type
        self.scheduledAt = training.scheduledAt
    }
    
    func saveOrDeleteTraining(fromContext modelContext: ModelContext) {
        isCreateTraining
        ? createTraining(modelContext: modelContext)
        : saveTraining()
    }
    
    private func createTraining(modelContext: ModelContext) {
        let newTraining = Training(
            name: trainingName,
            scheduledAt: scheduledAt,
            gymExercises: gymExercises,
            customExercises: customExercises,
            karateExercises: karateExercises,
            type: training.type
        )
        modelContext.insert(newTraining)
    }
    
    private func saveTraining() {
        training.name = trainingName
        switch training.type {
        case .gym: training.gymExercises = gymExercises
        case .custom: training.customExercises = customExercises
        case .karate: training.karateExercises = karateExercises
        }
    }
}
