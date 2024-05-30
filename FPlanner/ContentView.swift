//
//  ContentView.swift
//  FPlanner
//
//  Created by Fatih Kagan Emre on 27/05/2024.
//

import SwiftUI
import SwiftData

struct ContentView: View {
    @Environment(\.modelContext) private var modelContext
    @Query private var trainings: [Training]

    var body: some View {
        NavigationStack {
            List {
                ForEach(trainings) { training in
                    NavigationLink {
                        TrainingPlanView(
                            trainingName: training.name,
                            exerciseList: training.exercise ?? []
                        )
                    } label: {
                        VStack(alignment: .leading) {
                            Text(training.name).font(.title)
                            Text("Training at \(training.creationDate, format: Date.FormatStyle(date: .numeric, time: .standard))")
                        }
                    }
                }
                .onDelete(perform: deleteItems)
            }
            .navigationTitle("Training Plans")
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    EditButton()
                        .disabled(trainings.isEmpty)
                }
                ToolbarItem {
                    NavigationLink {
                        TrainingPlanView()
                    } label: {
                        Label("Add Training", systemImage: "plus")
                    }
                }
            }
        }
    }

    private func deleteItems(offsets: IndexSet) {
        withAnimation {
            for index in offsets {
                modelContext.delete(trainings[index])
            }
        }
    }
}

#Preview {
    ContentView()
        .modelContainer(for: Training.self, inMemory: true)
}
