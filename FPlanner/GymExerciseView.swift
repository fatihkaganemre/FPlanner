//
//  GymExerciseView.swift
//  FPlanner
//
//  Created by Fatih Kagan Emre on 02/06/2024.
//

import SwiftUI

struct GymExerciseView: View {
    @State var exercise: GymExercise = .init()
    @Binding var exerciseList: [GymExercise]
    @Binding var isEditing: Bool
    
    var body: some View {
        VStack(alignment: .leading, spacing: 5) {
            TextField("Exercise name", text: $exercise.name)
                .font(.headline)
            TextField("Number of sets", text: $exercise.numberOfSets)
            TextField("Number of reps", text: $exercise.numberOfReps)
            HStack {
                TextField("Max weight", text: $exercise.maxWeight)
                Text("kg")
            }
    
            Button("\(isEditing ? "Save" : "Add") Exercise") {
                if isEditing {
                    isEditing.toggle()
                } else {
                    exerciseList.append(exercise)
                    exercise = .init()
                }
            }
            .buttonStyle(.borderedProminent)
            .disabled(
                exercise.name.isEmpty
                || exercise.numberOfSets.isEmpty
                || exercise.numberOfReps.isEmpty
                || exercise.maxWeight.isEmpty
            )
            // TODO: - Check validation in iOS
        }
    }
}

#Preview {
    GymExerciseView(
        exerciseList: .constant([]),
        isEditing: .constant(false)
    )
}
