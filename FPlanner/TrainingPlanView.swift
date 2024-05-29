//
//  TrainingPlanView.swift
//  FPlanner
//
//  Created by Fatih Kagan Emre on 27/05/2024.
//

import SwiftUI

struct TrainingPlanView: View {
    @Environment(\.modelContext) private var modelContext
    @State private var exercise = Exercise()
    @State private var exerciseList: [Exercise] = []
    @State private var trainingName: String = ""
    
    private var exercises = ["Bench Press", "Dumbbell Press", "Dumbbell fly"]
    
    var body: some View {
        List {
            Section {
                TextField("Enter training name", text: $trainingName)
                    .font(.title)
            }
            
            ForEach(exerciseList) { exercise in
                VStack(alignment: .leading) {
                    Text(exercise.name).font(.title)
                    Text("Number of reps: \(exercise.numberOfReps)")
                    Text("Number of sets: \(exercise.numberOfSets)")
                    Text("Max weight: \(exercise.maxWeight) kg")
                }
            }.onDelete(perform: deleteItems)
            
            Section {
                Picker("Select the exercise", selection: $exercise.name) {
                    ForEach(exercises, id: \.self) { exercise in
                        Text(exercise)
                    }
                }
                TextField("Number of sets", text: $exercise.numberOfSets)
                TextField("Number of reps", text: $exercise.numberOfReps)
                HStack {
                    TextField("Max weight", text: $exercise.maxWeight)
                    Text("kg")
                }
                
                Button(action: {
                    exerciseList.append(exercise)
                    exercise = Exercise()
                }, label: {
                    Label("Add Item", systemImage: "plus")
                })
            }
            
            Section {
                Button(action: {
                    createTraining()
                },label: {
                    Text("Create training")
                })
            }
        }
        .toolbar {
            ToolbarItem(placement: .navigationBarTrailing) {
                EditButton()
                    .disabled(exercises.isEmpty)
            }
        }
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
