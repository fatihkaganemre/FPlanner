//
//  GymTrainingView.swift
//  FPlanner
//
//  Created by Fatih Kagan Emre on 01/06/2024.
//

import SwiftUI
import SwiftData

@MainActor
class GymTrainingViewModel: ObservableObject {
    @Published var exercise = GymExercise()
    @Published var trainingName: String
    @Published var exerciseList: [GymExercise]
    
    private let training: Training?
    var isCreateTraining: Bool {
        training == nil
    }
    
    var buttonTitle: String {
        isCreateTraining ? "Create": "Save"
    }
    
    init(training: Training? = nil) {
        self.training = training
        self.trainingName = training?.name ?? ""
        self.exerciseList = training?.gymExercises ?? []
    }
    
    func deleteItems(offsets: IndexSet) {
        for index in offsets {
            exerciseList.remove(at: index)
        }
    }
    
    func saveOrDeleteTraining(fromContext modelContext: ModelContext) {
        isCreateTraining
        ? createTraining(modelContext: modelContext)
        : saveTraining()
    }
    
    private func createTraining(modelContext: ModelContext) {
        let newTraining = Training(
            name: trainingName,
            gymExercises: exerciseList
        )
        modelContext.insert(newTraining)
    }
    
    private func saveTraining() {
        training?.name = trainingName
        training?.gymExercises = exerciseList
    }
}

struct GymTrainingView: View {
    @Environment(\.modelContext) private var modelContext
    @StateObject var viewModel: GymTrainingViewModel

    var body: some View {
        List {
            Section("Title") {
                TextField("Enter training name", text: $viewModel.trainingName)
                    .font(.title2)
            }
            
            ForEach(viewModel.exerciseList) { exercise in
                VStack(alignment: .leading) {
                    Text(exercise.name).font(.headline)
                    HStack {
                        Text("\(exercise.numberOfSets) sets")
                        Text("\(exercise.numberOfReps) reps")
                    }
                    Text("Max: \(exercise.maxWeight) kg")
                }
            }.onDelete(perform: deleteItems)
            
            Section("Add an exercise") {
                GymExerciseView(
                    exercise: $viewModel.exercise,
                    exerciseList: $viewModel.exerciseList
                )
            }.focusable()
        }
        .navigationTitle("Gym training")
        .toolbar {
            ToolbarItem(placement: .navigationBarTrailing) {
                EditButton()
                    .disabled(viewModel.exerciseList.isEmpty)
            }
        }
        
        Section {
            Button(viewModel.buttonTitle) {
                viewModel.saveOrDeleteTraining(fromContext: modelContext)
            }
            .disabled(viewModel.exerciseList.isEmpty)
            .font(.title)
            .buttonStyle(.borderedProminent)
        }
    }
    
    private func deleteItems(offsets: IndexSet) {
        withAnimation {
            viewModel.deleteItems(offsets: offsets)
        }
    }
}

#Preview {
    GymTrainingView(viewModel: .init())
}
