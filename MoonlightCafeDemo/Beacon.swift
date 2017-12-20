//
//  Beacon.swift
//  MoonlightCafeDemo
//
//  Created by Jason Custodio on 12/19/17.
//  Copyright © 2017 Jason Custodio. All rights reserved.
//

import Foundation

struct Beacon {
  
  let uuid: UUID
  let major: CLBeaconMajorValue
  let minor: CLBeaconMinorValue
  
  init(uuid: UUID, major: CLBeaconMajorValue, minor: CLBeaconMinorValue) {
    self.uuid = uuid
    self.major = major
    self.minor = minor
  }
  
  init(uuid: String, major: CLBeaconMajorValue, minor: CLBeaconMinorValue) {
    self.init(uuid: UUID(uuidString: uuid)!, major: major, minor: minor)
  }
  
  var asString: String {
    get {
      return "\(uuid.uuidString):\(major):\(minor)"
    }
  }
  
  var asBeaconRegion: CLBeaconRegion {
    get {
      return CLBeaconRegion(proximityUUID: self.uuid, major: self.major, minor: self.minor, identifier: self.asString)
    }
  }

  func ==(lhs: BeaconID, rhs: BeaconID) -> Bool {
    return lhs.proximityUUID == rhs.proximityUUID
        && lhs.major == rhs.major
        && lhs.minor == rhs.minor
}
  
}
