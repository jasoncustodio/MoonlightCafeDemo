//
//  RoundButton.swift
//  MoonlightCafeDemo
//
//  Created by Jason Custodio on 2/11/18.
//  Copyright © 2018 Jason Custodio. All rights reserved.
//

import UIKit

@IBDesignable // Allows to build in interface builder
class RoundButton: UIButton {

  @IBInspectable var cornerRadius: CGFloat = 0 {
    didSet {
      self.layer.cornerRadius = cornerRadius
    }
  }
  
  @IBInspectable var borderWidth: CGFloat = 0 {
    didSet {
      self.layer.borderWidth = borderWidth
    }
  }
  
  @IBInspectable var borderColor: UIColor = .clear {
    didSet {
      self.layer.borderColor = borderColor.cgColor
    }
  }

}
