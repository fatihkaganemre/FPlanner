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
    var name: String
    var gymExercises: [GymExercise]? = []
    var customExercises: [CustomExercise]? = []
    
    init(
        name: String,
        date: Date = .now,
        gymExercises: [GymExercise] = [],
        customExercises: [CustomExercise] = []
    ) {
        self.name = name
        self.creationDate = date
        self.gymExercises = gymExercises
        self.customExercises = customExercises
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
