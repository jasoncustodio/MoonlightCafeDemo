//
//  ArtistTableViewCell.swift
//  MoonlightCafeDemo
//
//  Created by Jason Custodio on 12/14/17.
//  Copyright © 2017 Jason Custodio. All rights reserved.
//

import UIKit

class ArtistTableViewCell: UITableViewCell {
  
  @IBOutlet weak var artistView: UIView!
  
  @IBOutlet weak var profileImageView: UIImageView!
  
  @IBOutlet weak var descriptionLabel: UILabel!
  
  func setArtist(artist: Artist) {
    profileImageView.image = artist.profileImage
    descriptionLabel.text = artist.description
    
    // Rounded Image
    artistView.layer.cornerRadius = artistView.frame.height/2
    
    profileImageView.layer.cornerRadius = profileImageView.frame.height/2
    profileImageView.clipsToBounds = true
    profileImageView.layer.borderColor = UIColor.black.cgColor
    profileImageView.layer.borderWidth = 2
  }
  
}
