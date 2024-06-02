//
//  CustomExerciseView.swift
//  FPlanner
//
//  Created by Fatih Kagan Emre on 02/06/2024.
//

import SwiftUI

struct CustomExerciseView: View {
    @Binding var exercise: CustomExercise
    @Binding var exerciseList: [CustomExercise]
    
    var body: some View {
        VStack(spacing: 5) {
            TextField("Name", text: $exercise.name)
                .font(.headline)
            TextField("Description", text: $exercise.description)
                .font(.subheadline)
            
            Button("Add Exercise") {
                exerciseList.append(exercise)
                exercise = CustomExercise()
            }
            .buttonStyle(.borderedProminent)
            .disabled(
                exercise.name.isEmpty
                || exercise.description.isEmpty
            )
            // TODO: - Check validation in iOS
        }
    }
}

#Preview {
    CustomExerciseView(
        exercise: .constant(.init()),
        exerciseList: .constant([])
    )
}
