//
//  AppDelegate.swift
//  TImeBurg
//
//  Created by Nebo on 09.05.2023.
//

import UIKit
import UserNotifications

class AppDelegate: NSObject, UIApplicationDelegate, UNUserNotificationCenterDelegate {
    
    func application( _ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]? ) -> Bool {
        UNUserNotificationCenter.current().delegate = self
        UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .badge, .sound], completionHandler: { _, _ in
            DispatchQueue.main.async {
                application.registerForRemoteNotifications() }
        } )
        return true
    }
    
    //MARK: - Notifications registration
    func application( _ application: UIApplication, didRegisterForRemoteNotificationsWithDeviceToken deviceToken: Data ) {
        let tokenParts = deviceToken.map { String(format: "%02.2hhx", $0 ) }
        let token = tokenParts.joined()
        print( "---Device Notifications Token: \(token)" )
    }

    func application( _ application: UIApplication, didFailToRegisterForRemoteNotificationsWithError error: Error ) {
        print( "---Failed to register Notifications: \(error)" )
    }
    
}
