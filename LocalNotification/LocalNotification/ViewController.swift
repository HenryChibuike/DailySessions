//
//  ViewController.swift
//  LocalNotification
//
//  Created by Henry-chime chibuike on 2/17/20.
//  Copyright © 2020 Henry-chime chibuike. All rights reserved.
//

import UIKit
import UserNotifications

class ViewController: UIViewController, UNUserNotificationCenterDelegate {

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .cyan
        
        navigationItem.leftBarButtonItem = .init(title: "Register", style: .done, target: self, action: #selector(Register))
        
        navigationItem.rightBarButtonItem = .init(title: "Schedule", style: .done, target: self, action: #selector(Schedule))
    }

    @objc func Register(){
        let center = UNUserNotificationCenter.current()
        
        center.requestAuthorization(options: [.alert, .badge, .sound]) { (granted, error) in
            if granted {
                print("Yay!")
            } else {
                print("D'oh")
            }
        }
    }
    
    @objc func Schedule(){
        
        registerCategories()
        
        let center = UNUserNotificationCenter.current()
        center.removeAllPendingNotificationRequests()
        
          let content = UNMutableNotificationContent()
          content.title = "Late wake up call"
          content.body = "The early bird catches the worm, but the second mouse gets the cheese."
          content.categoryIdentifier = "alarm"
          content.userInfo = ["customData": "fizzbuzz"]
          content.sound = UNNotificationSound.default
        
          let content2 = UNMutableNotificationContent()
          content2.title = "Remind me later"
          content2.categoryIdentifier = "alarm"
          content2.userInfo = ["customData2":"buzzFizz"]
          content2.sound = UNNotificationSound.default

          var dateComponents = DateComponents()
          dateComponents.hour = 10
          dateComponents.minute = 30
//          let trigger = UNCalendarNotificationTrigger(dateMatching: dateComponents, repeats: true)
        let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 5, repeats: false)
        let trigger2 = UNTimeIntervalNotificationTrigger(timeInterval: 10, repeats: false)

        let request = UNNotificationRequest(identifier: UUID().uuidString, content: content, trigger: trigger)
        let request2 = UNNotificationRequest(identifier: UUID().uuidString, content: content2, trigger: trigger2)
        
          center.add(request2)
          center.add(request)
    }

    func registerCategories() {
        let center = UNUserNotificationCenter.current()
        center.delegate = self

        let show = UNNotificationAction(identifier: "show", title: "Tell me more…", options: .foreground)
        let category = UNNotificationCategory(identifier: "alarm", actions: [show], intentIdentifiers: [])

        center.setNotificationCategories([category])
    }
    
    func userNotificationCenter(_ center: UNUserNotificationCenter, didReceive response: UNNotificationResponse, withCompletionHandler completionHandler: @escaping () -> Void) {
        // pull out the buried userInfo dictionary
        let userInfo = response.notification.request.content.userInfo

        if let customData = userInfo["customData"] as? String {
            print("Custom data received: \(customData)")

            switch response.actionIdentifier {
            case UNNotificationDefaultActionIdentifier:
                // the user swiped to unlock
                print("Default identifier")

            case "show":
                // the user tapped our "show more info…" button
                let showAlert = UIAlertController(title: "SHOW", message: "Show More Info", preferredStyle: .alert)
                showAlert.addAction(UIAlertAction(title: "okay", style: .destructive))
                present(showAlert, animated: true)
                print("Show more information…")

            default:
                break
            }
        }

        // you must call the completion handler when you're done
        completionHandler()
    }
}

