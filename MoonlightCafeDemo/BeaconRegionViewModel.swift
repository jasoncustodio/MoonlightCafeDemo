//
//  BeaconModelController.swift
//  MoonlightCafeDemo
//
//  Created by Jason Custodio on 12/19/17.
//  Copyright © 2017 Jason Custodio. All rights reserved.
//

import UIKit
import Foundation

final class BeaconRegionViewModel: NSObject {
  
  // MARK: - Properties
  let beaconManager = ESTBeaconManager()
  var beaconRegionList = [BeaconRegion]()
  var selectedBeaconRegion: BeaconRegion?
  var selectedArtist = Artist()
  
  // MARK: - Methods
  override init() {
    super.init()
    
    self.beaconManager.requestAlwaysAuthorization()
    self.beaconManager.delegate = self
    
    getBeaconData()
  }
  
  // Used only for testing
  func testBeacon() {
    self.selectedBeaconRegion = beaconRegionList[0]
  }
  
  func getNumberOfRows() -> Int {
    return selectedBeaconRegion?.artistList.count ?? 0
  }
  
  func getSelectedArtist() -> Artist {
    return self.selectedArtist
  }
  
  func getArtist(indexPath: IndexPath) -> Artist {
    return (self.selectedBeaconRegion?.artistList[indexPath.row])!
  }
  
  func setSelectedArtist(indexPath: IndexPath) {
    self.selectedArtist = (self.selectedBeaconRegion?.artistList[indexPath.row])!
  }
  
  // MARK: - Network Controller Helper
  private func getBeaconData() {
    
    let apiCall = NetworkController()
    
    apiCall.getBeaconData() { (data) in
      
      for beacon in data {
        
        guard let notification = beacon["notification"] as? [String:Any],
          let addBeacon = Beacon(dict: beacon),
          let addNotification = Notification(dict: notification),
          let addArtist = beacon["artists"] as? [[String:Any]]
          else { return }
        
        var beaconRegion = BeaconRegion(beacon: addBeacon, notification: addNotification, id: addBeacon.id)
        
        for artist in addArtist {
          
          guard let singleArtist = Artist(dict: artist) else {return}
          
          beaconRegion.addArtist(artist: singleArtist)
        }
        
        self.beaconRegionList.append(beaconRegion)
      }
      
      for beaconRegion in self.beaconRegionList {
        let region = beaconRegion.asBeaconRegion
        self.beaconManager.startMonitoring(for: region)
      }
      
      self.testBeacon()
    }
  }
  
}

// MARK: - Beacon Delegate
extension BeaconRegionViewModel: ESTBeaconManagerDelegate {
  
  // Did enter beacon region event trigger
  func beaconManager(_ manager: Any, didEnter region: CLBeaconRegion) {
    
    print("Entered")
    
    for beaconRegion in beaconRegionList{
      if (beaconRegion.asBeaconRegion == region) {
        self.selectedBeaconRegion = beaconRegion
        beaconRegion.createAlert()
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
    print("Monitoring failed for region: \(region?.identifier ?? "(unknown)"). Make sure that Bluetooth and Location Services are on, and that Location Services are allowed for this app. The error was: \(error) \n")
  }
  
}
