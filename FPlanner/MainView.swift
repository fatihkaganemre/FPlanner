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
                    Text("Create Gym training")
                        .font(.title2)
                }
                .padding()
                
                NavigationLink(value: TrainingType.custom)  {
                    Text("Create Custom training")
                        .font(.title2)
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
