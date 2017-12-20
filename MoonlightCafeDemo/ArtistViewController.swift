//
//  ArtistViewController.swift
//  MoonlightCafeDemo
//
//  Created by Jason Custodio on 10/26/17.
//  Copyright © 2017 Jason Custodio. All rights reserved.
//

import UIKit

class ArtistViewController: UIViewController {
  
  @IBOutlet weak var profileImage: UIImageView!
  @IBOutlet weak var bio: UILabel!
  @IBOutlet weak var image1: UIImageView!
  @IBOutlet weak var image2: UIImageView!
  @IBOutlet weak var image3: UIImageView!
  @IBOutlet weak var image4: UIImageView!
  
  var artist: Artist?
  
  func setImage() {
    profileImage.layer.cornerRadius = profileImage.frame.size.width/2
    
    profileImage.clipsToBounds = true
    profileImage.layer.borderColor = UIColor.black.cgColor
    profileImage.layer.borderWidth = 2
    
    profileImage.image = artist?.profileImage
    bio.text = artist?.description
    
    image1.image = artist?.imageArray[0]
    image2.image = artist?.imageArray[1]
    image3.image = artist?.imageArray[2]
    image4.image = artist?.imageArray[3]
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    setImage()
  }
  
  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
  }
}
