//
//  ArtistTableViewCell.swift
//  MoonlightCafeDemo
//
//  Created by Jason Custodio on 12/14/17.
//  Copyright © 2017 Jason Custodio. All rights reserved.
//

import UIKit

class ArtistTableViewCell: UITableViewCell {

  @IBOutlet weak var profileImage: UIImageView!

  @IBOutlet weak var name: UILabel!

  func setArtist(artist: Artist) {
    profileImage.image = artist.profileImage
    name.text = artist.description
  }
  
}
