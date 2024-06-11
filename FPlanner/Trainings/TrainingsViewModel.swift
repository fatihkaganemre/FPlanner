//
//  TrainingsViewModel.swift
//  FPlanner
//
//  Created by Fatih Kagan Emre on 11/06/2024.
//

import SwiftUI
import SwiftData

class TrainingsViewModel: ObservableObject {
    @Published var searchText: String = ""
    @Published private var trainings: [Training] = []
    @Published var isShowingShareSheet = false
    var itemsToShare: [Any] = []
    var searchResults: [Training] {
        return searchText.isEmpty
            ? trainings
            : trainings.filter { $0.name?.contains(searchText) ?? false }
    }

    func updateTrainings(_ newTrainings: [Training]) {
        trainings = newTrainings
    }

    func deleteTraining(type: TrainingType, offsets: IndexSet, context: ModelContext) {
        for index in offsets {
            let filteredTrainings = trainings.filter { $0.type == type }
            let training  = filteredTrainings[index]
            context.delete(training)
        }
    }

    func shareTraining(_ training: Training?) {
        guard let training = training else { return }
        
        // Prepare items to share
        let trainingDetails = """
        Check out this training:
        Name: \(training.name ?? "No Name")
        Type: \(training.type.title)
        """
        
        itemsToShare = [trainingDetails]
        isShowingShareSheet = true
    }
}
