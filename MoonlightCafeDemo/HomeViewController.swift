//
//  ViewController.swift
//  MoonlightCafeDemo
//
//  Created by Jason Custodio on 10/26/17.
//  Copyright © 2017 Jason Custodio. All rights reserved.
//

import UIKit
import UserNotifications
import CoreLocation

class HomeViewController: UIViewController, UNUserNotificationCenterDelegate, CLLocationManagerDelegate {
  
  
  var locationManager: CLLocationManager = CLLocationManager()
 
  
  @IBAction func sendNotification(_ sender: Any) {
    createAlert(title: "Moonlight Cafe", subtitle: "SWIPE ME!", body: "Would you like to view Artists?")
  }
  
  // Allow notificaiton to popup in the foreground
  func userNotificationCenter(_ center: UNUserNotificationCenter, willPresent notification: UNNotification, withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {
    completionHandler([.alert, .sound])
  }
  
  // Allow events based on notification actions
  func userNotificationCenter(_ center: UNUserNotificationCenter, didReceive response: UNNotificationResponse, withCompletionHandler completionHandler: @escaping () -> Void) {
    if(response.actionIdentifier == "YES") {
      performSegue(withIdentifier: "artistList", sender: self)
    }
    completionHandler()
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    /*
    // Ask notification permission
    UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .sound, .badge], completionHandler: {didAllow, error in})
    UNUserNotificationCenter.current().delegate = self */
  }
  
  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
    // Dispose of any resources that can be recreated.
  }
  
}

// Create alert template
func createAlert(title: String, subtitle: String, body: String) {
  
  // Create Notification Actions
  let yesButton = UNNotificationAction(identifier: "YES", title: "YES", options: .foreground)
  let noButton = UNNotificationAction(identifier: "NO", title: "NO", options: .foreground)
  
  let category = UNNotificationCategory(identifier: "artistList", actions: [yesButton, noButton], intentIdentifiers: [], options: [])
  UNUserNotificationCenter.current().setNotificationCategories([category])
  
  // Create A Notification
  let content = UNMutableNotificationContent()
  content.title = title
  content.subtitle = subtitle
  content.body = body
  content.badge = 1
  content.categoryIdentifier = "artistList"
  
  let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 1, repeats: false)
  
  let request = UNNotificationRequest(identifier: "timer", content: content, trigger: trigger)
  UNUserNotificationCenter.current().add(request, withCompletionHandler: nil)
}

extension UIViewController {
  var appDelegate: AppDelegate {
    return UIApplication.shared.delegate as! AppDelegate
  }
}
