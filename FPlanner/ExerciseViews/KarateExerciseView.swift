//
//  KarateExerciseView.swift
//  FPlanner
//
//  Created by Fatih Kagan Emre on 06/06/2024.
//

import SwiftUI

struct KarateExerciseView: View {
    @State private var exercise: KarateExercise = .init()
    @Binding var exerciseList: [KarateExercise]
    
    var body: some View {
        VStack(alignment: .leading, spacing: 5) {
            TextField("Name", text: $exercise.name)
                .font(.headline)
            TextField("Description", text: $exercise.description)
                .font(.subheadline)
            HStack {
                TextField("Duration", text: $exercise.durationInMin)
                    .font(.subheadline)
                Text("min")
                    .font(.subheadline)
            }
            Button("Add Exercise") {
                exerciseList.append(exercise)
                exercise = .init()
            }
            .buttonStyle(.borderedProminent)
            .disabled(
                exercise.name.isEmpty
                || exercise.description.isEmpty
                || exercise.durationInMin.isEmpty
            )
            // TODO: - Check validation in iOS
        }
    }
}

#Preview {
    KarateExerciseView(exerciseList: .constant([]))
}
