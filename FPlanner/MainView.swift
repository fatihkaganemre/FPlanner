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
                NavigationLink {
                    GymTrainingView(viewModel: .init())
                        .toolbar(.hidden, for: .tabBar)
                } label: {
                    Text("Create Gym training")
                        .font(.title2)
                }
                .padding()
            
                NavigationLink {
                    CustomTrainingView()
                        .toolbar(.hidden, for: .tabBar)
                } label: {
                    Text("Create Custom training")
                        .font(.title2)
                }
                .padding()
            }
            .navigationTitle("Create a training")
        }
    }
}

#Preview {
    MainView()
}
