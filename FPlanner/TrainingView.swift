//
//  TrainingView.swift
//  FPlanner
//
//  Created by Fatih Kagan Emre on 01/06/2024.
//

import SwiftUI
import SwiftData

struct TrainingView: View {
    @Environment(\.modelContext) private var modelContext
    @StateObject var viewModel: TrainingViewModel

    var body: some View {
        List {
            Section("Title") {
                TextField("Enter training name", text: $viewModel.trainingName)
                    .font(.title2)
                DatePicker("Scheduled at", selection: $viewModel.scheduledAt)
            }
            
            Section {
                ExerciseListView(
                    trainingType: viewModel.trainingType,
                    customExercises: $viewModel.customExercises,
                    gymExercises: $viewModel.gymExercises, 
                    karateExercises: $viewModel.karateExercises
                )
            }
            
            Section("Add an exercise") {
                switch viewModel.trainingType {
                    case .gym: GymExerciseView(exerciseList: $viewModel.gymExercises)
                    case .custom: CustomExerciseView(exerciseList: $viewModel.customExercises)
                    case .karate: KarateExerciseView(exerciseList: $viewModel.karateExercises)
                }
            }
        }
        .navigationTitle(viewModel.navigationTitle)
        .toolbar {
            ToolbarItem(placement: .navigationBarTrailing) {
                EditButton()
                    .disabled(viewModel.isExerciseListEmpty)
            }
        }
        .toolbar(.hidden, for: .tabBar)
        
        Section {
            Button(viewModel.buttonTitle) {
                viewModel.saveOrDeleteTraining(fromContext: modelContext)
            }
            .disabled(viewModel.isExerciseListEmpty)
            .font(.title)
            .buttonStyle(.borderedProminent)
        }
    }
}

#Preview {
    TrainingView(viewModel: .init(training: .init(type: .custom)))
}
