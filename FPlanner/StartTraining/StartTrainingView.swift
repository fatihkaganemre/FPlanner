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
            Text(training.name)
                .font(.largeTitle)
                .padding()
            TrainingView()
                .padding()
            Spacer()
        }
    }
    
    @ViewBuilder
    @MainActor
    private func TrainingView() -> some View {
        switch training.type {
            case .gym: StartGymTrainingView(viewModel: .init(exercises: training.gymExercises))
            case .karate: StartKarateTrainingView(viewModel: .init(exercises: training.karateExercises))
            case .custom: StartCustomTrainingView(viewModel: .init(exercises: training.customExercises))
        }
    }
}

#Preview {
    StartTrainingView(
        training: Training(
            name: "Example training",
            gymExercises: mockGymExercises,
            customExercises: mockCustomExercises,
            karateExercises: mockKarateExercises,
            type: .karate
        )
    )
}
