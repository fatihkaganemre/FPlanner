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
            List(TrainingType.allCases) { type in
                let trainingsWithType = trainings.filter { $0.type == type }
                if !trainingsWithType.isEmpty {
                    Section("\(type.title) trainings") {
                        ForEach(trainingsWithType) { training in
                            NavigationLink(value: training) {
                                VStack(alignment: .leading) {
                                    Text(training.name ?? "").font(.title)
                                    Text("Created: \(training.scheduledAt.formatted(date: .abbreviated, time: .shortened))")
                                }
                            }
                        }
                        .onDelete {
                            deleteTraining(type: type, offsets: $0)
                        }
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
    

    private func deleteTraining(type: TrainingType, offsets: IndexSet) {
        withAnimation {
            for index in offsets {
                let trainings = trainings.filter { $0.type == type }
                let training  = trainings[index]
                modelContext.delete(training)
            }
        }
    }

}

#Preview {
    TrainingsView()
        .modelContainer(for: Training.self, inMemory: true)
}
