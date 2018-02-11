//
//  ArtistDetailViewController.swift
//  MoonlightCafeDemo
//
//  Created by Jason Custodio on 10/26/17.
//  Copyright © 2017 Jason Custodio. All rights reserved.
//

import UIKit

class ArtistDetailViewController: UIViewController {
  
  @IBOutlet weak var profileImage: UIImageView!
  @IBOutlet weak var bio: UILabel!
  @IBOutlet weak var image1: UIImageView!
  @IBOutlet weak var image2: UIImageView!
  @IBOutlet weak var image3: UIImageView!
  @IBOutlet weak var image4: UIImageView!
  
  var beaconRegionViewModel: BeaconRegionViewModel!
  
  override func viewDidLoad() {
    super.viewDidLoad()
    setImage()
  }
  
  // Set border properties for artwork
  func setBorderColor(image: UIImageView) {
    image.layer.borderColor = UIColor.gray.cgColor
    image.layer.borderWidth = 2
  }
  
  // Create rounded borders for profile image
  func roundProfileImage() {
    profileImage.layer.cornerRadius = profileImage.frame.size.width/2
    profileImage.clipsToBounds = true
    profileImage.layer.borderColor = UIColor.gray.cgColor
    profileImage.layer.borderWidth = 2
  }
  
  // Set Artist detail view based on selected artist from tableView
  func setImage() {
    
    let artist = beaconRegionViewModel.getSelectedArtist()
    
    roundProfileImage()
    profileImage.downloadedFrom(link:artist.profileImage!)
    bio.text = artist.description
    
    image1.downloadedFrom(link: artist.imageArray[0])
    image2.downloadedFrom(link: artist.imageArray[1])
    image3.downloadedFrom(link: artist.imageArray[2])
    image4.downloadedFrom(link: artist.imageArray[3])
 
    setBorderColor(image: image1)
    setBorderColor(image: image2)
    setBorderColor(image: image3)
    setBorderColor(image: image4)
  }
  
}
