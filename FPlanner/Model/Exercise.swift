//
//  Exercise.swift
//  FPlanner
//
//  Created by Fatih Kagan Emre on 29/05/2024.
//

import Foundation
import SwiftData

let mockGymExercises: [GymExercise] = [
    GymExercise(name: "Exercise1", numberOfReps: "12", numberOfSets: "3", maxWeight: "120"),
    GymExercise(name: "Exercise2", numberOfReps: "12", numberOfSets: "3", maxWeight: "100"),
    GymExercise(name: "Exercise3", numberOfReps: "12", numberOfSets: "3", maxWeight: "90")
]

struct GymExercise: Codable, Identifiable, Hashable {
    var id = UUID()
    var name: String
    var numberOfReps: String
    var numberOfSets: String
    var maxWeight: String
    
    init(name: String = "", numberOfReps: String = "", numberOfSets: String = "", maxWeight: String = "") {
        self.name = name
        self.numberOfReps = numberOfReps
        self.numberOfSets = numberOfSets
        self.maxWeight = maxWeight
    }
}

let mockCustomExercises: [CustomExercise] = [
    CustomExercise(name: "Exercise1", description: "Desc1"),
    CustomExercise(name: "Exercise2", description: "Desc2"),
    CustomExercise(name: "Exercise3", description: "Desc3")
]

struct CustomExercise: Codable, Identifiable, Hashable {
    var id = UUID()
    var name: String
    var description: String
    
    init(name: String = "", description: String = "") {
        self.name = name
        self.description = description
    }
}

let mockKarateExercises: [KarateExercise] = [
    KarateExercise(name: "Exercise1", description: "Desc1", durationInMin: "1"),
    KarateExercise(name: "Exercise2", description: "Desc2", durationInMin: "1"),
    KarateExercise(name: "Exercise3", description: "Desc3", durationInMin: "1")
]

struct KarateExercise: Codable, Identifiable, Hashable {
    var id = UUID()
    var name: String
    var description: String
    var durationInMin: String
    
    init(name: String = "", description: String = "", durationInMin: String = "") {
        self.name = name
        self.description = description
        self.durationInMin = durationInMin
    }
}
