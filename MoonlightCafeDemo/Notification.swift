//
//  Notification.swift
//  MoonlightCafeDemo
//
//  Created by Jason Custodio on 12/18/17.
//  Copyright © 2017 Jason Custodio. All rights reserved.
//

import Foundation
import UserNotifications

class Notification {
  
  var title: String?
  var subtitle: String?
  var body: String?
  
  
  init(title: String, subtitle: String, body: String) {
    self.title = title
    self.subtitle = subtitle
    self.body = body
  }
  
  // Create alert template
  func createAlert() {
    
    // Create Notification Actions
    let yesButton = UNNotificationAction(identifier: "YES", title: "YES", options: .foreground)
    let noButton = UNNotificationAction(identifier: "NO", title: "NO", options: .foreground)
    
    let category = UNNotificationCategory(identifier: "artistList", actions: [yesButton, noButton], intentIdentifiers: [], options: [])
    UNUserNotificationCenter.current().setNotificationCategories([category])
    
    // Create A Notification
    let content = UNMutableNotificationContent()
    content.title = self.title!
    content.subtitle = self.subtitle!
    content.body = self.body!
    content.badge = 1
    content.categoryIdentifier = "artistList"
    
    let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 1, repeats: false)
    
    let request = UNNotificationRequest(identifier: "timer", content: content, trigger: trigger)
    UNUserNotificationCenter.current().add(request, withCompletionHandler: nil)
  }
  
}
