//
//  Notification.swift
//  MoonlightCafeDemo
//
//  Created by Jason Custodio on 12/18/17.
//  Copyright © 2017 Jason Custodio. All rights reserved.
//

import Foundation
import UserNotifications

struct Notification {
  
  // MARK: - Properties
  var title: String?
  var subtitle: String?
  var body: String?
  var id: Int
  
  // MARK: - Constructors
  init(title: String, subtitle: String, body: String, id: Int) {
    self.title = title
    self.subtitle = subtitle
    self.body = body
    self.id = id
  }
  
  init?(dict: [String: Any]) {
    
    guard let title = dict["title"] as? String,
      let subtitle = dict["subtitle"] as? String,
      let body = dict["body"] as? String,
      let id = dict["id"] as? Int else {
        return nil
    }
        
    self.init(title: title, subtitle: subtitle, body: body, id: id)
  }
  
  // MARK: - Methods
  func createAlert() {
    
    // Create A Notification
    let content = UNMutableNotificationContent()
    content.title = self.title!
    content.subtitle = self.subtitle!
    content.body = self.body!
    content.badge = 1
    
    let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 1, repeats: false)
    
    let request = UNNotificationRequest(identifier: "timer", content: content, trigger: trigger)
    UNUserNotificationCenter.current().add(request, withCompletionHandler: nil)
  }
  
}
