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
                let gymTrainings = trainings.filter { $0.type == .gym }
                let customTrainings = trainings.filter { $0.type == .custom}
                let karateTrainings = trainings.filter { $0.type == .karate}
                
                if !gymTrainings.isEmpty {
                    Section("Gym trainings") {
                        ForEach(gymTrainings) { training in
                            NavigationLink(value: training) {
                                VStack(alignment: .leading) {
                                    Text(training.name ?? "").font(.title)
                                    Text("Created: \(training.creationDate.formatted(date: .abbreviated, time: .shortened))")
                                }
                            }
                        }
                        .onDelete(perform: deleteGymTraining)
                    }
                }
                
                if !customTrainings.isEmpty {
                    Section("Custom Trainings") {
                        ForEach(customTrainings) { training in
                            NavigationLink(value: training) {
                                VStack(alignment: .leading) {
                                    Text(training.name ?? "").font(.title)
                                    Text("Created: \(training.creationDate.formatted(date: .abbreviated, time: .shortened))")
                                }
                            }
                        }
                        .onDelete(perform: deleteCustomTraining)
                    }
                }
                
                if !karateTrainings.isEmpty {
                    Section("Karate Trainings") {
                        ForEach(karateTrainings) { training in
                            NavigationLink(value: training) {
                                VStack(alignment: .leading) {
                                    Text(training.name ?? "").font(.title)
                                    Text("Scheduled: \(training.scheduledAt.formatted(date: .abbreviated, time: .shortened))")
                                }
                            }
                        }
                        .onDelete(perform: deleteCustomTraining)
                    }
                }
            }
            .navigationTitle("Trainings")
            .navigationDestination(for: Training.self) { training in
                TrainingView(viewModel: .init(training: training))
            }
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
                let gymTrainings = trainings.filter { $0.type == .gym }
                let training  = gymTrainings[index]
                modelContext.delete(training)
            }
        }
    }
    
    private func deleteCustomTraining(offsets: IndexSet) {
        withAnimation {
            for index in offsets {
                let customTrainings = trainings.filter { $0.type == .custom }
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
