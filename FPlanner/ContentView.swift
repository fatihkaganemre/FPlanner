//
//  ContentView.swift
//  FPlanner
//
//  Created by Fatih Kagan Emre on 27/05/2024.
//

import SwiftUI
import SwiftData
import UserNotifications
import Combine

struct ContentView: View {
    @Query private var trainings: [Training]
    @EnvironmentObject private var notificationObserver: TrainingNotificationObserver
    
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
        .sheet(isPresented: $notificationObserver.didReceiveNotification, content: {
            if let training = getTrainingFromNotification() {
                StartTrainingView(training: training)
            }
        })
    }
    
    private func getTrainingFromNotification() -> Training? {
        let trainingName = notificationObserver.receivedNotification?.targetContentIdentifier
        return trainings.first(where: { $0.name == trainingName })
    }
}

#Preview {
    ContentView()
}
