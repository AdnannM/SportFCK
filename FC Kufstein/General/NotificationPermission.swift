//
//  NotificationPermission.swift
//  FC Kufstein
//
//  Created by Adnann Muratovic on 24.11.23.
//

import UserNotifications

class NotificationHandler {
    static let shared = NotificationHandler()
    
    private init() {}
    
    func requestNotificationPermission() {
        UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .badge, .sound]) { granted, error in
            if granted {
                print("Notification permission granted")
            } else {
                print("Notification permission denied")
            }
        }
    }
}
