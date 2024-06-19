//
//  TrainingNotificationObserver.swift
//  FPlanner
//
//  Created by Fatih Kagan Emre on 15/06/2024.
//

import Foundation
import UserNotifications

@MainActor
final class TrainingNotificationObserver: NSObject, ObservableObject {
    @Published var receivedNotification: UNNotificationContent?
    @Published var didReceiveNotification: Bool = false
    
    override init() {
        super.init()
        UNUserNotificationCenter.current().delegate = self
    }
}

extension TrainingNotificationObserver: UNUserNotificationCenterDelegate {
    func userNotificationCenter(_ center: UNUserNotificationCenter, didReceive response: UNNotificationResponse) async {
        let content = response.notification.request.content
        if content.categoryIdentifier == TrainingNotificationService.categoryId {
            receivedNotification = content
            didReceiveNotification = true
        }
    }
}
