//
//  ExerciseView.swift
//  FPlanner
//
//  Created by Fatih Kagan Emre on 29/05/2024.
//

import SwiftUI

struct ExerciseView: View {
    @Binding var exercise: Exercise
    @Binding var exerciseList: [Exercise]
    
    var body: some View {
        VStack(spacing: 5) {
            TextField("Exercise name", text: $exercise.name)
                .font(.headline)
            TextField("Number of sets", text: $exercise.numberOfSets)
            TextField("Number of reps", text: $exercise.numberOfReps)
            HStack {
                TextField("Max weight", text: $exercise.maxWeight)
                Text("kg")
            }
            
            Button("Add Exercise") {
                exerciseList.append(exercise)
                exercise = Exercise()
            }
            .buttonStyle(.borderedProminent)
            .disabled(
                exercise.name.isEmpty
                || exercise.numberOfSets.isEmpty
                || exercise.numberOfReps.isEmpty
                || exercise.maxWeight.isEmpty
            )
        }
    }
}

#Preview {
    ExerciseView(
        exercise:  .constant(.init()),
        exerciseList: .constant([])
    )
}
