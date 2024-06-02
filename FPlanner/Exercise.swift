//
//  Exercise.swift
//  FPlanner
//
//  Created by Fatih Kagan Emre on 29/05/2024.
//

import Foundation
import SwiftData

struct GymExercise: Codable, Identifiable {
    var id = UUID()
    var name: String
    var numberOfReps: String
    var numberOfSets: String
    var maxWeight: String
    
    init(name: String, numberOfReps: String, numberOfSets: String, maxWeight: String) {
        self.name = name
        self.numberOfReps = numberOfReps
        self.numberOfSets = numberOfSets
        self.maxWeight = maxWeight
    }
    
    init() {
        self.name = ""
        self.numberOfReps = ""
        self.numberOfSets = ""
        self.maxWeight = ""
    }
}

struct CustomExercise: Codable, Identifiable {
    var id = UUID()
    var name: String
    var description: String
    
    init(name: String = "", description: String = "") {
        self.name = name
        self.description = description
    }
}
