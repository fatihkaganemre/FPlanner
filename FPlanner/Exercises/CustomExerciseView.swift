//
//  CustomExerciseView.swift
//  FPlanner
//
//  Created by Fatih Kagan Emre on 02/06/2024.
//

import SwiftUI

struct CustomExerciseView: View {
    @State private var exercise: CustomExercise = .init()
    @Binding var exerciseList: [CustomExercise]
    
    var body: some View {
        VStack(alignment: .leading, spacing: 5) {
            TextField("Name", text: $exercise.name)
                .font(.headline)
            TextField("Description", text: $exercise.description)
                .font(.subheadline)
            
            Button("Add Exercise") {
                withAnimation {
                    exerciseList.append(exercise)
                    exercise = .init()
                }
            }
            .buttonStyle(.borderedProminent)
            .disabled(
                exercise.name.isEmpty
                || exercise.description.isEmpty
            )
            .padding(.top, 5)
        }
    }
}

#Preview {
    CustomExerciseView(
        exerciseList: .constant([])
    )
}
