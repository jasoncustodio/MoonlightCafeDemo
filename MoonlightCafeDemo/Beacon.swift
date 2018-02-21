//
//  Beacon.swift
//  MoonlightCafeDemo
//
//  Created by Jason Custodio on 12/19/17.
//  Copyright © 2017 Jason Custodio. All rights reserved.
//

import Foundation

struct Beacon: Equatable {
  
  // MARK: - Properties
  let uuid: UUID
  let major: CLBeaconMajorValue
  let minor: CLBeaconMinorValue
  let id: Int
  
  // MARK: - Constructors
  init(uuid: UUID, major: CLBeaconMajorValue, minor: CLBeaconMinorValue, id: Int) {
    self.uuid = uuid
    self.major = major
    self.minor = minor
    self.id = id
  }
  
  init(uuidString: String, major: CLBeaconMajorValue, minor: CLBeaconMinorValue, id: Int) {
    self.init(uuid: UUID(uuidString: uuidString)!, major: major, minor: minor, id: id)
  }
  
  init?(dict: [String: Any]) {
    guard let uuid = dict["uuid"] as? String,
      let major = dict["major"] as? CLBeaconMajorValue,
      let minor = dict["minor"] as? CLBeaconMinorValue,
      let id = dict["id"] as? Int else { return nil }
    
    self.init(uuidString: uuid, major: major, minor: minor, id: id)
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
  
  static func ==(lhs: Beacon, rhs: Beacon) -> Bool {
    return lhs.uuid == rhs.uuid
      && lhs.major == rhs.major
      && lhs.minor == rhs.minor
  }
  
}
