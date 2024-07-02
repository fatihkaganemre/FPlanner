//
//  GymExerciseView.swift
//  FPlanner
//
//  Created by Fatih Kagan Emre on 02/06/2024.
//

import SwiftUI

struct GymExerciseView: View {
    @State private var exercise: GymExercise = .init()
    @State private var numberOfSets = 1
    @State private var numberOfReps = 1
    @Binding var exerciseList: [GymExercise]
    
    var body: some View {
        VStack(alignment: .leading, spacing: 5) {
            TextField("Exercise name", text: $exercise.name)
                .font(.headline)
            Picker("Number of Sets", selection: $numberOfSets) {
                ForEach(1..<10, id: \.self) {
                    Text("\($0)")
                }
            }
            
            Picker("Number of Reps", selection: $numberOfReps) {
                ForEach(1..<20, id: \.self) {
                    Text("\($0)")
                }
            }

            HStack {
                TextField("Max weight", text: $exercise.maxWeight)
                Text("kg")
            }
    
            Button("Add Exercise") {
                withAnimation {
                    addExercise()
                }
            }
            .buttonStyle(.borderedProminent)
            .disabled(
                exercise.name.isEmpty || exercise.maxWeight.isEmpty
            )
            .padding(.top, 5)
        }
    }
    
    private func addExercise() {
        var newExercise = exercise
        newExercise.numberOfReps = String(numberOfReps)
        newExercise.numberOfSets = String(numberOfSets)
        exerciseList.append(newExercise)
        exercise = .init()
    }
}

#Preview {
    GymExerciseView(
        exerciseList: .constant([])
    )
}
