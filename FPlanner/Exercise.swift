//
//  Exercise.swift
//  FPlanner
//
//  Created by Fatih Kagan Emre on 29/05/2024.
//

import Foundation
import SwiftData

@Model
final class Exercise: Identifiable, Hashable {
    let id = UUID()
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
