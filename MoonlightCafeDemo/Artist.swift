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
  var profileImage: String?
  var description: String?
  var imageArray = [String]()
  
  init?(dict: [String: Any]) {
    
    guard let description = dict["name"] as? String,
      let profileImage = dict["avatar_url"] as? String,
      let image1 = dict["artwork_1_url"] as? String,
      let image2 = dict["artwork_2_url"] as? String,
      let image3 = dict["artwork_3_url"] as? String,
      let image4 = dict["artwork_4_url"] as? String
      else {return nil}
    
    self.profileImage = profileImage
    self.description = description
    imageArray.append(image1)
    imageArray.append(image2)
    imageArray.append(image3)
    imageArray.append(image4)
    
  }
  
}
