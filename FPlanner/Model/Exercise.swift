//
//  Exercise.swift
//  FPlanner
//
//  Created by Fatih Kagan Emre on 29/05/2024.
//

import Foundation
import SwiftData

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

struct CustomExercise: Codable, Identifiable, Hashable {
    var id = UUID()
    var name: String
    var description: String
    
    init(name: String = "", description: String = "") {
        self.name = name
        self.description = description
    }
}

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
