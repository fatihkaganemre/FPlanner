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
    @Environment(\.dismiss) private var dismiss
    @StateObject var viewModel: TrainingViewModel
    
    var body: some View {
        VStack {
            List {
                Section("Title") {
                    TextField("Enter training name", text: $viewModel.trainingName)
                        .font(.title2)
                    DatePicker("Scheduled at", selection: $viewModel.scheduledAt)
                    Toggle("Repeat", isOn: $viewModel.isTrainingRepeats)
                }
                
                if !viewModel.isExerciseListEmpty {
                    Section("Exercises") {
                        ExerciseListView(
                            trainingType: viewModel.trainingType,
                            customExercises: $viewModel.customExercises,
                            gymExercises: $viewModel.gymExercises,
                            karateExercises: $viewModel.karateExercises
                        )
                    }
                }
                
                Section("Add an exercise") {
                    switch viewModel.trainingType {
                        case .gym: GymExerciseView(exerciseList: $viewModel.gymExercises)
                        case .custom: CustomExerciseView(exerciseList: $viewModel.customExercises)
                        case .karate: KarateExerciseView(exerciseList: $viewModel.karateExercises)
                    }
                }
            }
            
            SaveOrDeleteButton()
        }
        .background(Color(.systemGray6))
        .navigationTitle(viewModel.navigationTitle)
        .toolbar {
            ToolbarItem(placement: .navigationBarTrailing) {
                EditButton()
                    .disabled(viewModel.isExerciseListEmpty)
                    .foregroundStyle(
                        viewModel.isExerciseListEmpty ? Color.gray : Color("darkGreen")
                    )
            }
        }
        .toolbar(.hidden, for: .tabBar)
    }
    
    @ViewBuilder
    private func SaveOrDeleteButton() -> some View {
        Button {
            viewModel.saveOrDeleteTraining(fromContext: modelContext)
            dismiss()
        } label: {
            HStack {
                Spacer()
                Text(viewModel.buttonTitle).padding()
                Spacer()
            }
        }
        .disabled(viewModel.isExerciseListEmpty)
        .font(.title)
        .foregroundColor(.white)
        .background(viewModel.isExerciseListEmpty ? Color.gray : Color("darkGreen"))
        .cornerRadius(10)
        .padding()
    }
}

#Preview {
    NavigationView {
        TrainingView(viewModel: .init(training: .init(name: "Example custom training", type: .custom)))
    }
}
