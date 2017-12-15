//
//  AppDelegate.swift
//  MoonlightCafeDemo
//
//  Created by Jason Custodio on 10/26/17.
//  Copyright © 2017 Jason Custodio. All rights reserved.
//

import UIKit
import UserNotifications

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

  var window: UIWindow?

  var artist = [Artist]()

  func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
    // Override point for customization after application launch.
    
    let artist1 = Artist()
    artist1.profileImage = #imageLiteral(resourceName: "Unknown")
    artist1.description = "I am cat"
    artist1.imageArray[0] = #imageLiteral(resourceName: "Unknown3")
    artist1.imageArray[1] = #imageLiteral(resourceName: "Unknown2")
    artist1.imageArray[2] = #imageLiteral(resourceName: "Unknown1")
    artist1.imageArray[3] = #imageLiteral(resourceName: "Unknown4")
    
    let artist2 = Artist()
    artist2.profileImage = #imageLiteral(resourceName: "Unknown5")
    artist2.description = "I am dog"
    artist2.imageArray[0] = #imageLiteral(resourceName: "Unknown6")
    artist2.imageArray[1] = #imageLiteral(resourceName: "Unknown7")
    artist2.imageArray[2] = #imageLiteral(resourceName: "Unknown8")
    artist2.imageArray[3] = #imageLiteral(resourceName: "Unknown9")
    
    let artist3 = Artist()
    artist3.profileImage = #imageLiteral(resourceName: "Unknown10")
    artist3.description = "I am cool"
    artist3.imageArray[0] = #imageLiteral(resourceName: "Unknown13")
    artist3.imageArray[1] = #imageLiteral(resourceName: "Unknown14")
    artist3.imageArray[2] = #imageLiteral(resourceName: "Unknown11")
    artist3.imageArray[3] = #imageLiteral(resourceName: "Unknown12")
    
    
    artist.append(artist1)
    artist.append(artist2)
    artist.append(artist3)
    
    return true
  }
  

  func applicationWillResignActive(_ application: UIApplication) {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
  }

  func applicationDidEnterBackground(_ application: UIApplication) {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
  }

  func applicationWillEnterForeground(_ application: UIApplication) {
    // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
  }

  func applicationDidBecomeActive(_ application: UIApplication) {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
  }

  func applicationWillTerminate(_ application: UIApplication) {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
  }
}

extension UIStoryboard {
  public class func getMainStoryboard() -> UIStoryboard {
    return UIStoryboard(name: "Main", bundle: nil)
  }
}
