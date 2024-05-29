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
    var exercise: [Exercise]? = []
    
    init(name: String, date: Date = .now, exercise: [Exercise]) {
        self.name = name
        self.creationDate = date
        self.exercise = exercise
    }
}
