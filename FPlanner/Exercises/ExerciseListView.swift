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
    @Binding var karateExercises: [KarateExercise]
    
    var body: some View {
        switch trainingType {
        case .gym:
            ForEach(gymExercises, id: \.name) { exercise in
                VStack(alignment: .leading) {
                    Text(exercise.name).font(.headline)
                    HStack {
                        Text("\(exercise.numberOfSets) sets")
                        Text("\(exercise.numberOfReps) reps")
                    }
                    Text("Max: \(exercise.maxWeight) kg")
                }
            }
            .onDelete(perform: deleteItems)
            .onMove(perform: move)
        case .custom:
            ForEach(customExercises) { exercise in
                VStack(alignment: .leading) {
                    Text(exercise.name).font(.headline)
                    Text(exercise.description)
                }
            }
            .onDelete(perform: deleteItems)
            .onMove(perform: move)
        case .karate:
            ForEach(karateExercises) { exercise in
                VStack(alignment: .leading) {
                    Text(exercise.name).font(.headline)
                    Text(exercise.description)
                    if let duration = calculateDuration(ofExercise: exercise) {
                        Text("Duration: " + duration)
                    }
                }
            }
            .onDelete(perform: deleteItems)
            .onMove(perform: move)
        }
    }
    
    private func calculateDuration(ofExercise exercise: KarateExercise) -> String? {
        var components = DateComponents()
        components.second = exercise.durationInSec
        let date = Calendar.current.date(from: components)
        return date?.formatted(date: .omitted, time: .standard)
    }
    
    private func deleteItems(offsets: IndexSet) {
        withAnimation {
            for index in offsets {
                switch trainingType {
                case .gym: gymExercises.remove(at: index)
                case .custom: customExercises.remove(at: index)
                case .karate: karateExercises.remove(at: index)
                }
            }
        }
    }
    
    func move(from source: IndexSet, to destination: Int) {
        withAnimation {
            switch trainingType {
                case .gym: gymExercises.move(fromOffsets: source, toOffset: destination)
                case .custom: customExercises.move(fromOffsets: source, toOffset: destination)
                case .karate: karateExercises.move(fromOffsets: source, toOffset: destination)
            }
        }
    }
}

#Preview {
    ExerciseListView(
        trainingType: .karate,
        customExercises: .constant(mockCustomExercises),
        gymExercises: .constant(mockGymExercises),
        karateExercises: .constant(mockKarateExercises)
    )
}
