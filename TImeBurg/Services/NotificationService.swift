//
//  NotificationService.swift
//  TImeBurg
//
//  Created by Nebo on 09.05.2023.
//

import Foundation
import UserNotifications

protocol NotificationServiceProtocol {
    func add(notification: SystemNotification) -> Bool
    func deleteAll(withType: NotificationType) -> Bool
}

class NotificationService: NotificationServiceProtocol {
    
    private let notificationCenter = UNUserNotificationCenter.current()
    
    func add(notification: SystemNotification) -> Bool {
        
        let content = UNMutableNotificationContent()
        content.title = notification.title
        content.body = notification.message
        content.sound = .default
        content.userInfo = ["notificationInfo": notification.type.rawValue]
        let dateComponents = Calendar.current.dateComponents([.year, .month, .day, .hour, .minute, .second], from: notification.showTime)
        let trigger = UNCalendarNotificationTrigger(dateMatching: dateComponents, repeats: false)
        let uuid = UUID().uuidString
        let request = UNNotificationRequest(identifier: uuid, content: content, trigger: trigger)
        
        print("---Added Notification \(notification)")
        self.notificationCenter.add(request, withCompletionHandler: {
            if $0 != nil { print("---ERROR added Notification - \(String(describing: $0))") }

        })
        return true
    }
    
    func deleteAll(withType: NotificationType) -> Bool {
        return true
    }
}
