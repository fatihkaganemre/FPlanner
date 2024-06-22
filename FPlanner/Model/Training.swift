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
    @Attribute(.unique) var name: String
    var creationDate: Date
    var scheduledAt: Date
    var gymExercises: [GymExercise]
    var karateExercises: [KarateExercise]
    var customExercises: [CustomExercise]
    var repeats: Bool
    let type: TrainingType
    
    init(
        name: String,
        date: Date = .now,
        scheduledAt: Date = .now,
        gymExercises: [GymExercise] = [],
        customExercises: [CustomExercise] = [],
        karateExercises: [KarateExercise] = [],
        repeats: Bool = false,
        type: TrainingType
    ) {
        self.name = name
        self.creationDate = date
        self.scheduledAt = scheduledAt
        self.gymExercises = gymExercises
        self.customExercises = customExercises
        self.karateExercises = karateExercises
        self.repeats = repeats
        self.type = type
    }
}

extension Training {
    static func predicate(
        name: String
    ) -> Predicate<Training> {
        return #Predicate<Training> { training  in
            training.name.contains(name)
        }
    }
}

extension Training: Identifiable {}
