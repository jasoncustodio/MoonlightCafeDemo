//
//  BeaconModelController.swift
//  MoonlightCafeDemo
//
//  Created by Jason Custodio on 12/19/17.
//  Copyright © 2017 Jason Custodio. All rights reserved.
//

import UIKit
import Foundation

class BeaconNotificationsManager: NSObject, ESTBeaconManagerDelegate {
  
  //Create instance of beacon manager from the Estimote Framework
  private let beaconManager = ESTBeaconManager()
  
  //lists to hold all notification and beacons
  private var notificationList = [Notification]()
  private var beaconList = [Beacon]()
  
  // Setup permissions
  override init() {
    super.init()
    
    self.beaconManager.requestAlwaysAuthorization()
    self.beaconManager.delegate = self
    
    getBeaconData()
  }
  
  // Obtain beacon information
  private func getBeaconData() {
    
    let beacon1 = Beacon(uuidString: "01234567-0123-0123-0123-012345678910", major: 42296, minor: 25327)
    let beacon2 = Beacon(uuidString: "01234567-0123-0123-0123-012345678910", major: 22179, minor: 32626)
    let beacon3 = Beacon(uuidString: "01234567-0123-0123-0123-012345678910", major: 54381, minor: 53700)
    let beacon4 = Beacon(uuidString: "01234567-0123-0123-0123-012345678910", major: 61236, minor: 25536)
    
    self.beaconList.append(beacon1)
    self.beaconList.append(beacon2)
    self.beaconList.append(beacon3)
    self.beaconList.append(beacon4)
    
    for beacon in beaconList {
      let beaconRegion = beacon.asBeaconRegion
      self.beaconManager.startMonitoring(for: beaconRegion)
    }
    
  }
  
  // Did enter beacon region event trigger
  func beaconManager(_ manager: Any, didEnter region: CLBeaconRegion) {
    
    print("Entered")
    let notification = Notification(title: "Moonlight Cafe",
                                    subtitle: "SWIPE ME!",
                                    body: "Would you like to view Artists?")
    
    for beacon in beaconList{
      if (beacon.asBeaconRegion == region) {
        
        notification.createAlert()
      }
    }
    
  }
  
  // Location Service Pemission Denied
  func beaconManager(_ manager: Any, didChange status: CLAuthorizationStatus) {
    if status == .denied || status == .restricted {
      NSLog("Location Services are disabled for this app, which means it won't be able to detect beacons.")
    }
  }
  
  // Bluetooth Beacon Connection Failure
  func beaconManager(_ manager: Any, monitoringDidFailFor region: CLBeaconRegion?, withError error: Error) {
    print("Monitoring failed for region: \(region?.identifier ?? "(unknown)"). Make sure that Bluetooth and Location Services are on, and that Location Services are allowed for this app. The error was: \(error)")
  }
  
}
