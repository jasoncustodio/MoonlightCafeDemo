//
//  ViewController.swift
//  MoonlightCafeDemo
//
//  Created by Jason Custodio on 10/26/17.
//  Copyright © 2017 Jason Custodio. All rights reserved.
//

import UIKit
import UserNotifications

class ViewController: UIViewController, UNUserNotificationCenterDelegate {
  
  @IBAction func sendNotification(_ sender: Any) {
    createAlert(title: "Moonlight Cafe", subtitle: "SWIPE ME!", body: "Choose An Artist!")
  }
  
  override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
    let artistController = segue.destination as! ArtistViewController
    
    artistController.myProfileImage = appDelegate.artist[appDelegate.currentArtist].profileImage!
    artistController.myBio = appDelegate.artist[appDelegate.currentArtist].description
    artistController.myImage1 = appDelegate.artist[appDelegate.currentArtist].imageArray[0]
    artistController.myImage2 = appDelegate.artist[appDelegate.currentArtist].imageArray[1]
    artistController.myImage3 = appDelegate.artist[appDelegate.currentArtist].imageArray[2]
    artistController.myImage4 = appDelegate.artist[appDelegate.currentArtist].imageArray[3]
    
  }
  // Allow notificaiton to popup in the foreground
  func userNotificationCenter(_ center: UNUserNotificationCenter, willPresent notification: UNNotification, withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {
    completionHandler([.alert, .sound])
  }
  
  // Allow events based on notification actions
  func userNotificationCenter(_ center: UNUserNotificationCenter, didReceive response: UNNotificationResponse, withCompletionHandler completionHandler: @escaping () -> Void) {
    
    switch response.actionIdentifier {
    case "artist1": performSegue(withIdentifier: "artist", sender: self)
    case "artist2": print("Artist 2")
    case "artist3": print("Artist 3")
    default: print("Artist")
    }
    completionHandler()
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    // Ask notification permission
    UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .sound, .badge], completionHandler: {didAllow, error in})
    
    UNUserNotificationCenter.current().delegate = self
  }

  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
    // Dispose of any resources that can be recreated.
  }

}

// Create alert template
func createAlert(title: String, subtitle: String, body: String) {
  
  // Create Notification Actions
  let artist1 = UNNotificationAction(identifier: "artist1", title: "Artist 1", options: .foreground)
  let artist2 = UNNotificationAction(identifier: "artist2", title: "Artist 2", options: .foreground)
  let artist3 = UNNotificationAction(identifier: "artist3", title: "Artist 3", options: .foreground)
  
  let category = UNNotificationCategory(identifier: "artistList", actions: [artist1, artist2, artist3], intentIdentifiers: [], options: [])
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
