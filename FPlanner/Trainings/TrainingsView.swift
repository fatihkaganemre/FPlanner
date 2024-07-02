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
    @ObservedObject private var viewModel = TrainingsViewModel()
    @Query private var trainings: [Training]

    var body: some View {
        NavigationStack {
            List(TrainingType.allCases) { type in
                let trainingsWithType = viewModel.searchResults.filter { $0.type == type }
                if !trainingsWithType.isEmpty {
                    TrainingSection(type: type, trainings: trainingsWithType)
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
                        .foregroundStyle(
                            trainings.isEmpty ? Color.gray : Color("darkGreen")
                        )
                }
            }
            .searchable(text: $viewModel.searchText, prompt: "Search by name")
            .onAppear { viewModel.updateTrainings(trainings) }
            .onChange(of: trainings) { viewModel.updateTrainings(trainings) }
            .sheet(isPresented: $viewModel.isShowingSheet) {
                switch viewModel.sheetType {
                    case let .share(items):
                        ShareSheet(items: items)
                    case let .start(training):
                        StartTrainingView(training: training)
                    case .none:
                        EmptyView()
                }
            }
        }
    }
    
    private func deleteTraining(type: TrainingType, offsets: IndexSet) {
        withAnimation {
            viewModel.deleteTraining(type: type, offsets: offsets, context: modelContext)
        }
    }
    
    @ViewBuilder
    private func TrainingSection(type: TrainingType, trainings: [Training]) -> some View {
        Section("\(type.title) trainings") {
            ForEach(trainings) { training in
                TrainingCellView(training: training)
                    .swipeActions(edge: .leading) {
                        Button("Share", systemImage: "square.and.arrow.up") {
                            viewModel.shareTraining(training)
                        }
                        .tint(.blue)
                        Button("Play", systemImage: "play.fill") {
                            viewModel.startTraining(training)
                        }
                        .tint(.green)
                    }
            }
            .onDelete { offsets in
                viewModel.deleteTraining(type: type, offsets: offsets, context: modelContext)
            }
        }
    }
}

#Preview {
    TrainingsView()
        .modelContainer(for: Training.self, inMemory: true)
}
