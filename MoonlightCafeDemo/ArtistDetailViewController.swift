//
//  ArtistDetailViewController.swift
//  MoonlightCafeDemo
//
//  Created by Jason Custodio on 10/26/17.
//  Copyright © 2017 Jason Custodio. All rights reserved.
//

import UIKit

class ArtistDetailViewController: UIViewController {
  
  // MARK: - Outlets
  @IBOutlet weak var profileImage: UIImageView!
  @IBOutlet weak var bio: UILabel!
  @IBOutlet var imageArray: [UIImageView]!
  
  // MARK: - Properties
  var beaconRegionViewModel: BeaconRegionViewModel!
  
  // MARK: - Methods
  override func viewDidLoad() {
    super.viewDidLoad()
    setImage()
  }
  
  // Create rounded borders for profile image
  func roundProfileImage() {
    profileImage.layer.cornerRadius = profileImage.frame.size.width/2
    profileImage.clipsToBounds = true
    profileImage.setBorderColor()
  }
  
  // Set Artist detail view based on selected artist from tableView
  func setImage() {
    
    let artist = beaconRegionViewModel.getSelectedArtist()
    
    roundProfileImage()
    profileImage.downloadedFrom(link:artist.profileImage!)
    bio.text = artist.description
    
    for index in imageArray.indices {
      imageArray[index].downloadedFrom(link: artist.imageArray[index])
      imageArray[index].setBorderColor()
    }
  }
}
