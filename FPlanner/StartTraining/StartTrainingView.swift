//
//  StartTrainingView.swift
//  FPlanner
//
//  Created by Fatih Kagan Emre on 14/06/2024.
//

import SwiftUI

struct StartTrainingView: View {
    var training: Training
    
    var body: some View {
        VStack {
            Spacer()
            Text(training.name ?? "Training").font(.largeTitle).padding()
            switch training.type {
                case .gym:
                    StartGymTrainingView(exercises: training.gymExercises)
                case .karate:
                    StartKarateTrainingView()
                case .custom:
                    StartCustomTrainingView()
            }
            Spacer()
        }
    }
}


#Preview {
    StartTrainingView(
        training: Training(
            gymExercises: mockGymExercises,
            customExercises: mockCustomExercises,
            karateExercises: mockKarateExercises,
            type: .gym
        )
    )
}
