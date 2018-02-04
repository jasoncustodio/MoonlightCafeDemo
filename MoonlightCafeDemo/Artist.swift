//
//  User.swift
//  MoonlightCafeDemo
//
//  Created by Jason Custodio on 10/26/17.
//  Copyright © 2017 Jason Custodio. All rights reserved.
//

import Foundation
import UIKit

struct Artist {
  var profileImage: UIImage? = nil
  var description: String = ""
  var imageArray = [UIImage]()
  
  init() {
    profileImage = nil
    description = ""
    imageArray.append(UIImage())
    imageArray.append(UIImage())
    imageArray.append(UIImage())
    imageArray.append(UIImage())
  }
  
  init(profileImage: UIImage, description: String) {
    self.profileImage = profileImage
    self.description = description
    imageArray.append(UIImage())
    imageArray.append(UIImage())
    imageArray.append(UIImage())
    imageArray.append(UIImage())
  }
  
}
