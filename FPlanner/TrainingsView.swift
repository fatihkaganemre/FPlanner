//
//  TrainingsView.swift
//  FPlanner
//
//  Created by Fatih Kagan Emre on 01/06/2024.
//

import SwiftUI
import SwiftData

struct TrainingsView: View {
    @Environment(\.modelContext) private var modelContext
    @Query private var trainings: [Training]

    var body: some View {
        NavigationStack {
            List {
                Section("Gym trainings") {
                    let gymTrainings = trainings.filter { !($0.gymExercises ?? []).isEmpty }
                    ForEach(gymTrainings) { training in
                        NavigationLink {
                            GymTrainingView(training: training)
                        } label: {
                            VStack(alignment: .leading) {
                                Text(training.name).font(.title)
                                Text("Created at \(training.creationDate, format: Date.FormatStyle(date: .numeric, time: .standard))")
                            }
                        }
                    }
                    .onDelete(perform: deleteGymTraining)
                }
                Section("Custom Trainings") {
                    let customTrainings = trainings.filter { !($0.customExercises ?? []).isEmpty }
                    ForEach(customTrainings) { training in
                        NavigationLink {
                            CustomTrainingView(training: training)
                        } label: {
                            VStack(alignment: .leading) {
                                Text(training.name).font(.title)
                                Text("Created at \(training.creationDate, format: Date.FormatStyle(date: .numeric, time: .standard))")
                            }
                        }
                    }
                    .onDelete(perform: deleteCustomTraining)
                }

            }
            .navigationTitle("Trainings")
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    EditButton()
                        .disabled(trainings.isEmpty)
                }
            }
        }
    }

    private func deleteGymTraining(offsets: IndexSet) {
        withAnimation {
            for index in offsets {
                let gymTrainings = trainings.filter { !($0.gymExercises ?? []).isEmpty }
                let training  = gymTrainings[index]
                modelContext.delete(training)
            }
        }
    }
    
    private func deleteCustomTraining(offsets: IndexSet) {
        withAnimation {
            for index in offsets {
                let customTrainings = trainings.filter { !($0.customExercises ?? []).isEmpty }
                let training  = customTrainings[index]
                modelContext.delete(training)
            }
        }
    }
}

#Preview {
    TrainingsView()
        .modelContainer(for: Training.self, inMemory: true)
}
