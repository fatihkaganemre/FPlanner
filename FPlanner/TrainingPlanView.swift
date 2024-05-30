//
//  TrainingPlanView.swift
//  FPlanner
//
//  Created by Fatih Kagan Emre on 27/05/2024.
//

import SwiftUI

struct TrainingPlanView: View {
    @Environment(\.modelContext) private var modelContext
    @State var exercise = Exercise()
    @State var trainingName: String = ""
    @State var exerciseList: [Exercise] = []

    
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
                ExerciseView(
                    exercise: $exercise,
                    exerciseList: $exerciseList
                )
            }.focusable()
        }
        .navigationTitle("Create a training")
        .toolbar {
            ToolbarItem(placement: .navigationBarTrailing) {
                EditButton()
                    .disabled(exerciseList.isEmpty)
            }
        }
        
        Button("Create training") {
            createTraining()
        }
        .font(.title2)
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
            exercise: exerciseList
        )
        modelContext.insert(newTraining)
    }
}

#Preview {
    TrainingPlanView()
}
