//
//  TrainingNotificationService.swift
//  FPlanner
//
//  Created by Fatih Kagan Emre on 11/06/2024.
//

import Foundation
import UserNotifications

enum NotificationAction: String {
    case start = "START_ACTION"
    
    var title: String {
        return "Start"
    }
}

protocol TrainingNotificationServiceProtocol {
    func createNotification(forTraining training: Training) async throws
}

class TrainingNotificationService: NSObject, TrainingNotificationServiceProtocol {
    private let calendar: Calendar
    private let notificationCenter: UNUserNotificationCenter
    static let categoryId = "START_TRAINING"
    
    init(calendar: Calendar = .current, notificationCenter: UNUserNotificationCenter = .current()) {
        self.calendar = calendar
        self.notificationCenter = notificationCenter
    }
    
    func createNotification(forTraining training: Training) async throws {
        guard try await requestNotificationAuthorization() else { return }
        let content = makeNotificationContent(forTraining: training)
        let trigger = makeTrigger(forTraining: training)
        setNotificationCategories(forTraining: training)
        try await registerNotification(content: content, trigger: trigger)
    }
    
    private func makeNotificationContent(forTraining training: Training) -> UNMutableNotificationContent {
        let content = UNMutableNotificationContent()
        content.title = training.name ?? "Training"
        content.body = "Scheduled at: \(training.scheduledAt.formatted(date: .omitted, time: .shortened))"
        content.sound = .default
        content.targetContentIdentifier = training.name
        content.categoryIdentifier = TrainingNotificationService.categoryId
        content.interruptionLevel = .timeSensitive
        return content
    }
    
    private func makeTrigger(forTraining training: Training) -> UNCalendarNotificationTrigger {
        let dateComponents = calendar.dateComponents(
            [.year, .month, .day, .hour, .minute],
            from: training.scheduledAt
        )
        return UNCalendarNotificationTrigger(
            dateMatching: dateComponents,
            repeats: training.repeats
        )
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
        try await notificationCenter.add(request)
    }
    
    private func requestNotificationAuthorization() async throws -> Bool {
        try await notificationCenter.requestAuthorization(options: [.alert, .sound, .badge])
    }
    
    private func setNotificationCategories(forTraining training: Training) {
        let actionIcon = UNNotificationActionIcon(systemImageName: training.type.imageName)
        let startAction = UNNotificationAction(
            identifier: NotificationAction.start.rawValue,
            title: NotificationAction.start.title,
            options: [],
            icon: actionIcon
        )
        let startTrainingCategory = UNNotificationCategory(
            identifier: TrainingNotificationService.categoryId,
            actions: [startAction],
            intentIdentifiers: [],
            options: []
        )
        notificationCenter.setNotificationCategories([startTrainingCategory])
    }
}
