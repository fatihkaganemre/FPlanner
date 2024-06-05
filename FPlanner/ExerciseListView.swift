//
//  ExerciseListView.swift
//  FPlanner
//
//  Created by Fatih Kagan Emre on 05/06/2024.
//

import SwiftUI

struct ExerciseListView: View {
    let trainingType: TrainingType
    @Binding var customExercises: [CustomExercise]
    @Binding var gymExercises: [GymExercise]
    @Binding var isEditing: Bool
    
    var body: some View {
        switch trainingType {
        case .gym:
            ForEach(gymExercises) { exercise in
                if isEditing {
                    GymExerciseView(
                        exercise: exercise,
                        exerciseList: $gymExercises,
                        isEditing: $isEditing
                    )
                } else {
                    VStack(alignment: .leading) {
                        HStack{
                            Text(exercise.name).font(.headline)
                            Spacer()
                            Button("", systemImage: "rectangle.and.pencil.and.ellipsis") {
                                isEditing.toggle()
                            }
                        }
                        HStack {
                            Text("\(exercise.numberOfSets) sets")
                            Text("\(exercise.numberOfReps) reps")
                        }
                        Text("Max: \(exercise.maxWeight) kg")
                    }
                }
            }.onDelete(perform: deleteItems)
        case .custom:
            ForEach(customExercises) { exercise in
                if isEditing {
                    CustomExerciseView(
                        exercise: exercise,
                        exerciseList: $customExercises,
                        isEditing: $isEditing
                    )
                } else {
                    VStack(alignment: .leading) {
                        HStack{
                            Text(exercise.name).font(.headline)
                            Spacer()
                            Button("", systemImage: "rectangle.and.pencil.and.ellipsis") {
                                isEditing.toggle()
                            }
                        }
                        Text(exercise.description)
                    }
                }
            }.onDelete(perform: deleteItems)
        }
    }
    
    private func deleteItems(offsets: IndexSet) {
        withAnimation {
            for index in offsets {
                switch trainingType {
                    case .gym: gymExercises.remove(at: index)
                    case .custom: customExercises.remove(at: index)
                }
            }
        }
    }
}

#Preview {
    ExerciseListView(
        trainingType: .custom,
        customExercises: .constant([]),
        gymExercises: .constant([]),
        isEditing: .constant(false)
    )
}
