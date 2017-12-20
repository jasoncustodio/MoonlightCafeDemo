//
//  Beacon.swift
//  MoonlightCafeDemo
//
//  Created by Jason Custodio on 12/19/17.
//  Copyright © 2017 Jason Custodio. All rights reserved.
//

import Foundation

struct Beacon {
  let proximity: UUID
  let major: CLBeaconMajorValue
  let minor: CLBeaconMinorValue
}
