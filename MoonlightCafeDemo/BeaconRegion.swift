//
//  Beacon.swift
//  MoonlightCafeDemo
//
//  Created by Jason Custodio on 12/19/17.
//  Copyright © 2017 Jason Custodio. All rights reserved.
//

import Foundation

struct BeaconRegion {
  
  var notification: Notification
  var beacon: Beacon
  var artistList = [Artist]()
  var id: Int
  
  init(uuidString: String, major: CLBeaconMajorValue, minor: CLBeaconMinorValue, title: String, subtitle: String, body: String, id: Int) {
    self.notification = Notification(title: title, subtitle: subtitle, body: body, id: id)
    self.beacon = Beacon(uuidString: uuidString, major: major, minor: minor, id: id)
    self.id = id
  }
  
  init(beacon: Beacon, notification: Notification, id: Int) {
    self.notification = notification
    self.beacon = beacon
    self.id = id
  }
  
  func createAlert() {
    self.notification.createAlert()
  }
  
  mutating func addArtist(artist: Artist) {
    self.artistList.append(artist)
  }
  
  var asBeaconRegion: CLBeaconRegion {
    get {
      return self.beacon.asBeaconRegion
    }
  }
  
}
