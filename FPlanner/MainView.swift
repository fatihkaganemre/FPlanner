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
                ForEach(TrainingType.allCases) { type in
                    NavigationLink(value: type)  {
                        HStack {
                            Image(systemName: type.imageName)
                            Text("\(type.title) training")
                                .font(.title3)
                        }
                    }
                    .padding()
                }
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
