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
  
    var myProfileImage = UIImage()
    var myBio = String()
    var myImage1 = UIImage()
    var myImage2 = UIImage()
    var myImage3 = UIImage()
    var myImage4 = UIImage()
  
    override func viewDidLoad() {
        super.viewDidLoad()
      
      
        profileImage.image = myProfileImage
        bio.text = myBio
      
        image1.image = myImage1
        image2.image = myImage2
        image3.image = myImage3
        image4.image = myImage4
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}
