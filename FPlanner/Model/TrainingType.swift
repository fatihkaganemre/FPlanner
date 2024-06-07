//
//  TrainingType.swift
//  FPlanner
//
//  Created by Fatih Kagan Emre on 06/06/2024.
//

import Foundation

enum TrainingType: Codable, CaseIterable, Identifiable {
    case gym
    case karate
    case custom
    
    var id: String {
        self.title
    }
    
    var imageName: String {
        switch self {
            case .gym: return "dumbbell.fill"
            case .custom: return "figure.mixed.cardio"
            case .karate: return "figure.martial.arts"
        }
    }
    
    var title: String {
        switch self {
            case .gym: return "Gym"
            case .custom: return "Custom"
            case .karate: return "Karate"
        }
    }
}
