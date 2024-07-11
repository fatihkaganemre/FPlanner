//
//  TrainingsViewModel.swift
//  FPlanner
//
//  Created by Fatih Kagan Emre on 11/06/2024.
//

import SwiftUI
import SwiftData

@MainActor
class TrainingsViewModel: ObservableObject {
    @Published var searchText: String = ""
    @Published private var trainings: [Training] = []
    @Published var isShowingSheet = false
    
    enum SheetType {
        case share(items: [Any])
        case start(training: Training)
    }
    
    private let notificationService: TrainingNotificationServiceProtocol
    var sheetType: SheetType?
    var searchResults: [Training] {
        guard !searchText.isEmpty else { return trainings }
        let searchResults = try? trainings.filter(Training.predicate(name: searchText))
        return searchResults ?? []
    }
    
    init(
        notificationService: TrainingNotificationServiceProtocol = TrainingNotificationService()
    ) {
        self.notificationService = notificationService
    }

    func updateTrainings(_ newTrainings: [Training]) {
        trainings = newTrainings
    }

    func deleteTraining(type: TrainingType, offsets: IndexSet, context: ModelContext) {
        for index in offsets {
            let filteredTrainings = trainings.filter { $0.type == type }
            let training  = filteredTrainings[index]
            notificationService.removeNotifications(withIdentifiers: [training.name])
            context.delete(training)
        }
    }

    func shareTraining(_ training: Training?) {
        guard let training = training else { return }
        
        // Prepare items to share
        let trainingDetails = """
        Check out this training:
        Name: \(training.name)
        Type: \(training.type.title)
        """
        
        sheetType = .share(items: [trainingDetails])
        isShowingSheet = true
    }
    
    func startTraining(_ training: Training) {
        sheetType = .start(training: training)
        isShowingSheet = true
    }
}
