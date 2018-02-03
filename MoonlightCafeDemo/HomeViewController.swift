//
//  ViewController.swift
//  MoonlightCafeDemo
//
//  Created by Jason Custodio on 10/26/17.
//  Copyright © 2017 Jason Custodio. All rights reserved.
//

import UIKit


class HomeViewController: UIViewController {
  
  var beaconRegionViewModel: BeaconRegionViewModel!
  
  @IBAction func sendNotification(_ sender: Any) {
    
    let notification = Notification(title: "Moonlight Cafe",
                                    subtitle: "SWIPE ME!",
                                    body: "Would you like to view Artists?",
                                    id: 0)
    notification.createAlert()
  }
  
  override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
    if segue.identifier == "artistList" {
      let artistTableViewController = segue.destination as! ArtistTableViewController
      artistTableViewController.beaconRegionViewModel = self.beaconRegionViewModel
    }
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
  }
  
  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
    // Dispose of any resources that can be recreated.
  }
  
}


