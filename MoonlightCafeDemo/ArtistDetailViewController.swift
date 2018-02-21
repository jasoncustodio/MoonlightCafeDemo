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
  @IBOutlet private weak var profileImage: UIImageView!
  @IBOutlet private weak var bio: UILabel!
  @IBOutlet private var imageArray: [UIImageView]!
  
  // MARK: - Properties
  var beaconRegionViewModel: BeaconRegionViewModel!
  
  // MARK: - Methods
  override func viewDidLoad() {
    super.viewDidLoad()
    setImage()
  }
  
  // Set Artist detail view based on selected artist from tableView
  private func setImage() {
    
    let artist = beaconRegionViewModel.getSelectedArtist()
    
    profileImage.roundImage()
    profileImage.grayBorderColor()
    profileImage.downloadedFrom(link:artist.profileImage!)
    bio.text = artist.description
    
    for index in imageArray.indices {
      imageArray[index].downloadedFrom(link: artist.imageArray[index])
      imageArray[index].grayBorderColor()
    }
  }
}
