//
//  BeaconModelController.swift
//  MoonlightCafeDemo
//
//  Created by Jason Custodio on 12/19/17.
//  Copyright © 2017 Jason Custodio. All rights reserved.
//

import UIKit
import Foundation

class BeaconRegionModelController: NSObject, ESTBeaconManagerDelegate {
  
  //Create instance of beacon manager from the Estimote Framework
  private let beaconManager = ESTBeaconManager()
  
  //lists to hold all notification and beacons
  private var beaconRegionList = [BeaconRegion]()
  
  private var selectedBeaconRegion = 0

  // Setup permissions
  override init() {
    super.init()
    
    self.beaconManager.requestAlwaysAuthorization()
    self.beaconManager.delegate = self
    
    getBeaconData()
    getArtistData()
  }
  
  // Obtain beacon information
  private func getBeaconData() {
    
    let uuid = "01234567-0123-0123-0123-012345678910"
    
    let beacon1 = Beacon(uuidString: uuid, major: 54381, minor: 53700)
    let beacon2 = Beacon(uuidString: uuid, major: 25140, minor: 11960)
    
    let notification1 = Notification(title: "Zone 1", subtitle: "Swipe me!", body: "Choose An Artist!")
    let notification2 = Notification(title: "Zone 2", subtitle: "Swipe me!", body: "Choose An Artist!")
    
    
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
    
    
    beaconRegionList[0].addArtist(artist: artist1)
    beaconRegionList[0].addArtist(artist: artist2)
    beaconRegionList[0].addArtist(artist: artist3)
    
    let artist4 = Artist()
    artist4.profileImage = #imageLiteral(resourceName: "pexels-photo-718978")
    artist4.description = "Arlene Schroender"
    artist4.imageArray[0] = #imageLiteral(resourceName: "pexels-photo-566041.jpeg")
    artist4.imageArray[1] = #imageLiteral(resourceName: "pexels-photo-716272.jpeg")
    artist4.imageArray[2] = #imageLiteral(resourceName: "pexels-photo-716643.jpeg")
    artist4.imageArray[3] = #imageLiteral(resourceName: "pexels-photo-716834.jpeg")
    
    let artist5 = Artist()
    artist5.profileImage = #imageLiteral(resourceName: "pexels-photo-715842")
    artist5.description = "Anne Cat"
    artist5.imageArray[0] = #imageLiteral(resourceName: "pexels-photo-717195.jpeg")
    artist5.imageArray[1] = #imageLiteral(resourceName: "pexels-photo-717513.jpeg")
    artist5.imageArray[2] = #imageLiteral(resourceName: "pexels-photo-717987.jpeg")
    artist5.imageArray[3] = #imageLiteral(resourceName: "pexels-photo-718002.jpeg")
    
    let artist6 = Artist()
    artist6.profileImage = #imageLiteral(resourceName: "pexels-photo-715231.jpeg")
    artist6.description = "Steph Bryers"
    artist6.imageArray[0] = #imageLiteral(resourceName: "pexels-photo-718143.jpeg")
    artist6.imageArray[1] = #imageLiteral(resourceName: "pexels-photo-718279.jpeg")
    artist6.imageArray[2] = #imageLiteral(resourceName: "pexels-photo-720240.jpeg")
    artist6.imageArray[3] = #imageLiteral(resourceName: "pexels-photo-720843.jpeg")
    
    
    beaconRegionList[1].addArtist(artist: artist4)
    beaconRegionList[1].addArtist(artist: artist5)
    beaconRegionList[1].addArtist(artist: artist6)
    
  }
  
  func fetchArtistList() -> [Artist] {
    return beaconRegionList[self.selectedBeaconRegion].getArtistList()
  }
  
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
    print("Monitoring failed for region: \(region?.identifier ?? "(unknown)"). Make sure that Bluetooth and Location Services are on, and that Location Services are allowed for this app. The error was: \(error)")
  }
  
}
