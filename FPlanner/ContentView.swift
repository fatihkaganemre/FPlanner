//
//  ContentView.swift
//  FPlanner
//
//  Created by Fatih Kagan Emre on 27/05/2024.
//

import SwiftUI
import SwiftData

struct ContentView: View {
    var body: some View {
        TabView {
            MainView()
                .tabItem {
                    Label("Create", systemImage: "plus")
                }
            TrainingsView()
                .tabItem {
                    Label("Trainings", systemImage: "list.dash")
                }
        }
        .tint(Color("darkGreen"))
        .onAppear {
            Task {
                do {
                    try await UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .sound, .badge, .provisional])
                } catch {
                    // TODO: - Handle error
                    print(error.localizedDescription)
                }
            }
        }
    }
}

#Preview {
    ContentView()
}
