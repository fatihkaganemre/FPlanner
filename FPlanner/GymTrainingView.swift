//
//  GymTrainingView.swift
//  FPlanner
//
//  Created by Fatih Kagan Emre on 01/06/2024.
//

import SwiftUI
import SwiftData

struct GymTrainingView: View {
    @Environment(\.modelContext) private var modelContext
    @State var exercise = GymExercise()
    @State var trainingName: String
    @State var exerciseList: [GymExercise]
    let training: Training?
    
    init(training: Training? = nil) {
        self.training = training
        self.trainingName = training?.name ?? ""
        self.exerciseList = training?.gymExercises ?? []
    }

    var body: some View {
        List {
            Section {
                TextField("Enter training name", text: $trainingName)
                    .font(.title)
            }
            
            ForEach(exerciseList) { exercise in
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
                    exercise: $exercise,
                    exerciseList: $exerciseList
                )
            }.focusable()
        }
        .navigationTitle("\(training == nil ? "Create": "Save") a training")
        .toolbar {
            ToolbarItem(placement: .navigationBarTrailing) {
                EditButton()
                    .disabled(exerciseList.isEmpty)
            }
        }
        
        Button("\(training == nil ? "Create": "Save") training") {
            training == nil ? createTraining(): saveTrainingPlan()
        }
        .font(.largeTitle)
        .frame(height: 80)
        .frame(maxWidth: .infinity)
        .foregroundColor(.white)
        .background(.blue)
    }
    
    private func deleteItems(offsets: IndexSet) {
        withAnimation {
            for index in offsets {
                exerciseList.remove(at: index)
            }
        }
    }
    
    private func createTraining() {
        let newTraining = Training(
            name: trainingName,
            gymExercises: exerciseList
        )
        modelContext.insert(newTraining)
    }
    
    private func saveTrainingPlan() {
        training?.name = trainingName
        training?.gymExercises = exerciseList
    }
}

#Preview {
    GymTrainingView(training: nil)
}
