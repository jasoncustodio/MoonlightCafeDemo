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
  
  func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
    
    configureNavigationBarAppearance()
    
    injectViewModel()
    
    setNotificationDelegate()
    
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

// Handle notifications
extension AppDelegate: UNUserNotificationCenterDelegate {
  
  // Set notification delegate
  func setNotificationDelegate() {
    let center = UNUserNotificationCenter.current()
    center.requestAuthorization(options: [.alert, .sound], completionHandler: {granted, error in} )
    center.delegate = self
  }
  
  // Allow notificaiton to popup in the foreground
  func userNotificationCenter(_ center: UNUserNotificationCenter, willPresent notification: UNNotification, withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {
    completionHandler([.alert, .sound])
  }
  
  // Allow events based on notification actions
  public func userNotificationCenter(_ center: UNUserNotificationCenter, didReceive response: UNNotificationResponse, withCompletionHandler completionHandler: @escaping () -> Void) {
    
    if let artistController = self.window?.rootViewController as? ArtistTableViewController {
      DispatchQueue.main.async { artistController.artistTableView.reloadData() }
    }
    else if let navigationController = self.window?.rootViewController as? UINavigationController {
      let initialViewController = navigationController.viewControllers.first
      initialViewController?.artistListSegue()
    }
    
    completionHandler()
  }
  
}

// Handle extra functions
extension AppDelegate {
  
  // Change navbar appearance
  func configureNavigationBarAppearance() {
    
    let navigationBarAppearance = UINavigationBar.appearance()
    navigationBarAppearance.tintColor = UIColor.white
    navigationBarAppearance.barTintColor = UIColor.black
    navigationBarAppearance.titleTextAttributes = [NSAttributedStringKey.foregroundColor: UIColor.white]
    UIApplication.shared.statusBarStyle = UIStatusBarStyle.lightContent
  }
  
  // View Model Dependency Injection
  func injectViewModel() {
    
    if let navigationController = self.window?.rootViewController as? UINavigationController {
      let homeViewController = navigationController.viewControllers.first as? HomeViewController
      homeViewController?.beaconRegionViewModel = BeaconRegionViewModel()
    }
  }
  
}
