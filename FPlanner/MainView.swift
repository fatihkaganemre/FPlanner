//
//  MainView.swift
//  FPlanner
//
//  Created by Fatih Kagan Emre on 01/06/2024.
//

import SwiftUI

struct MainView: View {
    var body: some View {
        NavigationStack {
            List {
                NavigationLink(value: TrainingType.gym)  {
                    HStack {
                        Image(systemName: "dumbbell.fill")
                        Text("Gym training")
                            .font(.title3)
                    }
                }
                .padding()
                
                NavigationLink(value: TrainingType.custom)  {
                    HStack {
                        Image(systemName: "figure.mixed.cardio")
                        Text("Custom training")
                            .font(.title3)
                    }
                }
                .padding()
                
                NavigationLink(value: TrainingType.karate)  {
                    HStack {
                        Image(systemName: "figure.martial.arts")
                        Text("Karate training")
                            .font(.title3)
                    }
                }
                .padding()
            }
            .navigationTitle("Create a training")
            .navigationDestination(for: TrainingType.self) { type in
                TrainingView(viewModel: .init(training: .init(type: type)))
            }
        }
    }
}

#Preview {
    MainView()
}
