//
//  Training.swift
//  FPlanner
//
//  Created by Fatih Kagan Emre on 27/05/2024.
//

import Foundation
import SwiftData

@Model
final class Training {
    var creationDate: Date
    var scheduledAt: Date
    var name: String?
    var gymExercises: [GymExercise]
    var karateExercises: [KarateExercise]
    var customExercises: [CustomExercise]
    let type: TrainingType
    
    init(
        name: String? = nil,
        date: Date = .now,
        scheduledAt: Date = .now,
        gymExercises: [GymExercise] = [],
        customExercises: [CustomExercise] = [],
        karateExercises: [KarateExercise] = [],
        type: TrainingType
    ) {
        self.name = name
        self.creationDate = date
        self.scheduledAt = scheduledAt
        self.gymExercises = gymExercises
        self.customExercises = customExercises
        self.karateExercises = karateExercises
        self.type = type
    }
}

extension Training {
    static func predicate(
        name: String
    ) -> Predicate<Training> {
        return #Predicate<Training> { training  in
            training.name == name
        }
    }
}

extension Training: Identifiable {}
