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
    @State var isEditingExercise: Bool = false

    var body: some View {
        List {
            Section("Title") {
                TextField("Enter training name", text: $viewModel.trainingName)
                    .font(.title2)
            }
            
            Section {
                ExerciseListView(
                    trainingType: viewModel.trainingType,
                    customExercises: $viewModel.customExercises,
                    gymExercises: $viewModel.gymExercises,
                    isEditing: $isEditingExercise
                )
            }
            if !isEditingExercise {
                Section("Add an exercise") {
                    switch viewModel.trainingType {
                        case .gym: GymExerciseView(exerciseList: $viewModel.gymExercises, isEditing: $isEditingExercise)
                        case .custom: CustomExerciseView(exerciseList: $viewModel.customExercises, isEditing: $isEditingExercise)
                    }
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
            .disabled(viewModel.isExerciseListEmpty || isEditingExercise)
            .font(.title)
            .buttonStyle(.borderedProminent)
        }
    }
}

#Preview {
    TrainingView(viewModel: .init(training: .init(type: .custom)))
}
