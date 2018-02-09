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
  var selectedBeaconRegion = 1
  var selectedArtist: Artist?
  var selectedArtistList = [Artist]()
  
  // MARK: - Methods
  override init() {
    super.init()
    
    // Setup permissions
    self.beaconManager.requestAlwaysAuthorization()
    self.beaconManager.delegate = self
    
    getBeaconData()
  }
  
  func getSelectedArtist() -> Artist {
    return self.selectedArtist!
  }
  
  func getNumberOfRows() -> Int {
    return selectedArtistList.count
  }
  
  func setSelectedArtist(indexPath: IndexPath) {
    self.selectedArtist = self.selectedArtistList[indexPath.row]
  }
  
  func setArtistList() {
    for beaconRegion in beaconRegionList {
      if beaconRegion.id == self.selectedBeaconRegion {
        self.selectedArtistList = beaconRegion.artistList
        return
      }
    }
  }
  
  // MARK: - Network Controller Helper
  private func getBeaconData() {
    
    let apiCall = NetworkController()
    
    apiCall.getBeaconData() { (data) in
            
      for beacon in data {
        
        guard let notification = beacon["notification"] as? [String:Any],
          let addBeacon = Beacon(dict: beacon),
          let addNotification = Notification(dict: notification)
          else { return }
        
        let beaconRegion = BeaconRegion(beacon: addBeacon, notification: addNotification, id: addBeacon.id)
        self.beaconRegionList.append(beaconRegion)
      }
      
      for beaconRegion in self.beaconRegionList {
        let region = beaconRegion.asBeaconRegion
        self.beaconManager.startMonitoring(for: region)
      }
      
      self.getArtistData()
      self.setArtistList()
    }
    
  }
  
  func getArtistData() {
    
    var artist1 = Artist()
    artist1.profileImage = #imageLiteral(resourceName: "moonlight0")
    artist1.description = "Moonlight Coffeehouse"
    artist1.imageArray[0] = #imageLiteral(resourceName: "moonlight1")
    artist1.imageArray[1] = #imageLiteral(resourceName: "moonlight4")
    artist1.imageArray[2] = #imageLiteral(resourceName: "moonlight2")
    artist1.imageArray[3] = #imageLiteral(resourceName: "moonlight3")
    
    var artist2 = Artist()
    artist2.profileImage = #imageLiteral(resourceName: "dragonfly0")
    artist2.description = "Dragonfly"
    artist2.imageArray[0] = #imageLiteral(resourceName: "dragonfly3")
    artist2.imageArray[1] = #imageLiteral(resourceName: "dragonfly4")
    artist2.imageArray[2] = #imageLiteral(resourceName: "dragonfly2")
    artist2.imageArray[3] = #imageLiteral(resourceName: "dragonfly1")
    
    var artist3 = Artist()
    artist3.profileImage = #imageLiteral(resourceName: "rock0")
    artist3.description = "Rock and Felt"
    artist3.imageArray[0] = #imageLiteral(resourceName: "rock1")
    artist3.imageArray[1] = #imageLiteral(resourceName: "rock3")
    artist3.imageArray[2] = #imageLiteral(resourceName: "rock4")
    artist3.imageArray[3] = #imageLiteral(resourceName: "rock2")
    
    
    beaconRegionList[0].addArtist(artist: artist1)
    beaconRegionList[0].addArtist(artist: artist2)
    beaconRegionList[0].addArtist(artist: artist3)
  }
  
}

// MARK: - Beacon Delegate
extension BeaconRegionViewModel: ESTBeaconManagerDelegate {
  
  // Did enter beacon region event trigger
  func beaconManager(_ manager: Any, didEnter region: CLBeaconRegion) {
    
    print("Entered")
    
    for beaconRegion in beaconRegionList{
      if (beaconRegion.asBeaconRegion == region) {
        self.selectedBeaconRegion = beaconRegion.id
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
