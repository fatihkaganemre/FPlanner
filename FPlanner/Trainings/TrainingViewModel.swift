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
    @Published var isTrainingRepeats: Bool = false
    
    private let training: Training
    private let notificationService: TrainingNotificationServiceProtocol
    
    let trainingType: TrainingType

    var buttonTitle: String {
        isCreateTraining ? "Create": "Save"
    }
    
    var navigationTitle: String {
        "\(trainingType.title) training"
    }
    
    var isExerciseListEmpty: Bool {
        customExercises.isEmpty
        && gymExercises.isEmpty
        && karateExercises.isEmpty
    }
    
    var isCreateTraining: Bool {
        training.name.isEmpty
    }
    
    init(
        training: Training,
        notificationService: TrainingNotificationServiceProtocol = TrainingNotificationService()
    ) {
        self.training = training
        self.notificationService = notificationService
        self.trainingName = training.name
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
            repeats: isTrainingRepeats,
            type: training.type
        )
        modelContext.insert(newTraining)
        scheduleNotification(for: newTraining)
    }
    
    private func saveTraining() {
        training.name = trainingName
        training.scheduledAt = scheduledAt
        training.repeats = isTrainingRepeats
        
        if training.scheduledAt > Date.now {
            notificationService.removeNotifications(withIdentifiers: [training.name])
            scheduleNotification(for: training)
        }
        
        switch training.type {
        case .gym: training.gymExercises = gymExercises
        case .custom: training.customExercises = customExercises
        case .karate: training.karateExercises = karateExercises
        }
    }
    
    private func scheduleNotification(for training: Training) {
        Task {
            do {
                try await notificationService.createNotification(forTraining: training)
            } catch {
                // TODO: Handle error appropriately, perhaps show an alert or log the error.
                print(error.localizedDescription)
            }
        }
    }
}
