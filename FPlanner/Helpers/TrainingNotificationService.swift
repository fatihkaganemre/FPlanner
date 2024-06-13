//
//  TrainingNotificationService.swift
//  FPlanner
//
//  Created by Fatih Kagan Emre on 11/06/2024.
//

import Foundation
import UserNotifications

struct TrainingNotificationService {
    private let calendar: Calendar
    private let notificationCenter: UNUserNotificationCenter
    
    init(
        calendar: Calendar = .current,
        notificationCenter: UNUserNotificationCenter = .current()
    ) {
        self.calendar = calendar
        self.notificationCenter = notificationCenter
    }
    
    func createNotification(forTraining training: Training) async throws {
        guard try await requestNotificationAuthorization() else { return }
        let content = makeNotificationContent(forTraining: training)
        let trigger = makeTrigger(forTraining: training)
        try await registerNotification(content: content, trigger: trigger)
    }
    
    private func makeNotificationContent(forTraining training: Training) -> UNMutableNotificationContent {
        let content = UNMutableNotificationContent()
        content.title = training.name ?? "Training"
        content.body = "Scheduled at: \(training.scheduledAt.formatted(date: .omitted, time: .shortened))"
        content.sound = .default
        return content
    }
    
    private func makeTrigger(forTraining training: Training) -> UNCalendarNotificationTrigger {
        let dateComponents = calendar.dateComponents(
            [.year, .month, .day, .hour, .minute],
            from: training.scheduledAt
        )
           
        // Create the trigger as a repeating event.
        return UNCalendarNotificationTrigger(
            dateMatching: dateComponents, repeats: training.repeats)
    }
    
    private func registerNotification(
        content: UNMutableNotificationContent,
        trigger: UNCalendarNotificationTrigger
    ) async throws {
        let uuidString = UUID().uuidString
        let request = UNNotificationRequest(
            identifier: uuidString,
            content: content,
            trigger: trigger
        )
        let notificationCenter = UNUserNotificationCenter.current()
        // Schedule the request with the system.
        try await notificationCenter.add(request)
    }
    
    private func requestNotificationAuthorization() async throws -> Bool {
        try await notificationCenter.requestAuthorization(options: [.alert, .sound, .badge, .provisional])
        let settings = await notificationCenter.notificationSettings()
        return settings.authorizationStatus == .authorized || settings.authorizationStatus == .provisional
    }
}
