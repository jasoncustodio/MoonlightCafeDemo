//
//  Extensions.swift
//  MoonlightCafeDemo
//
//  Created by Jason Custodio on 12/18/17.
//  Copyright © 2017 Jason Custodio. All rights reserved.
//

import UIKit
import Foundation
import UserNotifications

extension UIViewController {

  // Allow all views to segue to artistList after notification action
  func artistListSegue() {
    performSegue(withIdentifier: "artistList", sender: nil)
  }
  
}
