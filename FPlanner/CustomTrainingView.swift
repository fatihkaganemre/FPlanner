//
//  CustomTrainingView.swift
//  FPlanner
//
//  Created by Fatih Kagan Emre on 01/06/2024.
//

import SwiftUI


struct CustomTrainingView: View {
    @Environment(\.modelContext) private var modelContext
    @State var exercise = CustomExercise()
    @State var trainingName: String
    @State var exerciseList: [CustomExercise]
    let training: Training?
    
    init(training: Training? = nil) {
        self.training = training
        self.trainingName = training?.name ?? ""
        self.exerciseList = training?.customExercises ?? []
    }

    var body: some View {
        List {
            Section("Title") {
                TextField("Enter training name", text: $trainingName)
                    .font(.title2)
            }
            
            ForEach(exerciseList) { exercise in
                VStack(alignment: .leading) {
                    Text(exercise.name).font(.headline)
                    Text(exercise.description)
                }
            }.onDelete(perform: deleteItems)
            
            Section("Add an exercise") {
                CustomExerciseView(
                    exercise: $exercise,
                    exerciseList: $exerciseList
                )
            }.focusable()
        }
        .navigationTitle("Custom training")
        .toolbar {
            ToolbarItem(placement: .navigationBarTrailing) {
                EditButton()
                    .disabled(exerciseList.isEmpty)
            }
        }
        
        Button("\(training == nil ? "Create": "Save")") {
            training == nil ? createTraining(): saveTrainingPlan()
        }
        .disabled(exerciseList.isEmpty)
        .font(.title)
        .buttonStyle(.borderedProminent)
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
            customExercises: exerciseList
        )
        modelContext.insert(newTraining)
    }
    
    private func saveTrainingPlan() {
        training?.name = trainingName
        training?.customExercises = exerciseList
    }
}

#Preview {
    CustomTrainingView()
}
