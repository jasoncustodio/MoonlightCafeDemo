//
//  Extensions.swift
//  MoonlightCafeDemo
//
//  Created by Jason Custodio on 12/18/17.
//  Copyright © 2017 Jason Custodio. All rights reserved.
//

import UIKit
import Foundation
import UserNotifications

extension UIViewController {
  var appDelegate: AppDelegate {
    return UIApplication.shared.delegate as! AppDelegate
  }
}

extension UIViewController {
  func doSegue() {
    performSegue(withIdentifier: "artistList", sender: nil)
  }
}


extension AppDelegate: UNUserNotificationCenterDelegate {
  
  // Allow notificaiton to popup in the foreground
  func userNotificationCenter(_ center: UNUserNotificationCenter, willPresent notification: UNNotification, withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {
    completionHandler([.alert, .sound])
  }
  
  // Allow events based on notification actions
  public func userNotificationCenter(_ center: UNUserNotificationCenter, didReceive response: UNNotificationResponse, withCompletionHandler completionHandler: @escaping () -> Void) {
    if(response.actionIdentifier == "YES") {
      
      let rootViewController = self.window!.rootViewController
      rootViewController?.doSegue()
      
    }
    completionHandler()
  }
}
