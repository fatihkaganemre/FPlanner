//
//  CustomExerciseView.swift
//  FPlanner
//
//  Created by Fatih Kagan Emre on 02/06/2024.
//

import SwiftUI

struct CustomExerciseView: View {
    @State var exercise: CustomExercise = .init()
    @Binding var exerciseList: [CustomExercise]
    @Binding var isEditing: Bool
    
    var body: some View {
        VStack(alignment: .leading, spacing: 5) {
            TextField("Name", text: $exercise.name)
                .font(.headline)
            TextField("Description", text: $exercise.description)
                .font(.subheadline)
            
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
                || exercise.description.isEmpty
            )
            // TODO: - Check validation in iOS
        }
    }
}

#Preview {
    CustomExerciseView(
        exerciseList: .constant([]),
        isEditing: .constant(false)
    )
}
