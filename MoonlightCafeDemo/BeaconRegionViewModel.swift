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
  
  //Create instance of beacon manager from the Estimote Framework
  let beaconManager = ESTBeaconManager()
  
  //lists to hold all notification and beacons
  var beaconRegionList = [BeaconRegion]()
  var selectedBeaconRegion = 0
  var selectedArtist: Artist?
  var selectedArtistList = [Artist]()
  
  // Get artist to populate artist detail page
  func getSelectedArtist() -> Artist {
    return self.selectedArtist!
  }
  
  func getNumberOfRows() -> Int {
    return selectedArtistList.count
  }
  
  func setArtistList() {
    for beaconRegion in beaconRegionList {
      if beaconRegion.id == self.selectedBeaconRegion {
        self.selectedArtistList = beaconRegion.artistList
      }
    }
  }
  
  func setSelectedArtist(indexPath: IndexPath) {
    self.selectedArtist = self.selectedArtistList[indexPath.row]
  }
  
  // Setup permissions
  override init() {
    super.init()
    
    self.beaconManager.requestAlwaysAuthorization()
    self.beaconManager.delegate = self
    
    getBeaconData()
    getArtistData()
    setArtistList()
  }
  
  
  
  // Obtain beacon information
  private func getBeaconData() {
    
    /*
    var beaconList = [Beacon]()
    var notificationList = [Notification]()
    let apiCall = APICall()
    
    apiCall.getBeaconData() { (data) in
      for beacon in data {
        let add = Beacon(dict: beacon)
        beaconList.append(add)
      }
      print(data)
    }
    
    apiCall.getNotificationData() { (data) in
      for notification in data {
        let add = Notification(dict: notification)
        notificationList.append(add)
      }
      print(data)
    }
    
    
    for beacon in beaconList {
      for notification in notificationList {
        if beacon.id == notification.id {
          let add = BeaconRegion(beacon: beacon, notification: notification, id: beacon.id)
          self.beaconRegionList.append(add)
        }
      }
    }*/
    
    
    let uuid = "01234567-0123-0123-0123-012345678910"
    
    let beacon1 = Beacon(uuidString: uuid, major: 54381, minor: 53700, id: 1)
    let beacon2 = Beacon(uuidString: uuid, major: 25140, minor: 11960, id: 2)
    
    let notification1 = Notification(title: "Zone 1", subtitle: "Swipe me!", body: "Choose An Artist!", id: 1)
    let notification2 = Notification(title: "Zone 2", subtitle: "Swipe me!", body: "Choose An Artist!", id: 2)
    
    
    let beaconRegion1 = BeaconRegion.init(beacon: beacon1, notification: notification1, id: 0)
    let beaconRegion2 = BeaconRegion.init(beacon: beacon2, notification: notification2, id: 1)
  
    self.beaconRegionList.append(beaconRegion1)
    self.beaconRegionList.append(beaconRegion2)
  
    for beaconRegion in beaconRegionList {
      let region = beaconRegion.asBeaconRegion
      self.beaconManager.startMonitoring(for: region)
    }
    
  }
  
  private func getArtistData() {
    
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
