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
            List(TrainingType.allCases) { type in
                Section {
                    NavigationLink(value: type)  {
                        HStack {
                            Image(systemName: type.imageName)
                            Text("\(type.title) training")
                                .font(.title3)
                        }
                    }
                    .foregroundStyle(.white)
                    .padding()
                }
                .listRowBackground(Color(red: 6/255, green: 85/255, blue: 53/255))
            }
            .listSectionSpacing(.compact)
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
