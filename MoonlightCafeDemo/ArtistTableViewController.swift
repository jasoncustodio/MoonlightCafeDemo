//
//  ArtistTableViewController.swift
//  MoonlightCafeDemo
//
//  Created by Jason Custodio on 12/14/17.
//  Copyright © 2017 Jason Custodio. All rights reserved.
//

import UIKit

class ArtistTableViewController: UIViewController {
  
  @IBOutlet weak var artistTableView: UITableView!
  
  var beaconRegionViewModel: BeaconRegionViewModel!
  
  @IBAction func unwindSegue(_ sender: UIStoryboardSegue) { }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    artistTableView.delegate = self
    artistTableView.dataSource = self
  }
  
  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)
    
    DispatchQueue.main.async {
      self.beaconRegionViewModel.setArtistList()
      self.artistTableView.reloadData()
    }
  }
  
  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
  }
  
  override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
    
    if segue.identifier == "artistDetail" {
      let artistController = segue.destination as! ArtistDetailViewController
      artistController.beaconRegionViewModel = self.beaconRegionViewModel
    }
  }
  
}

extension ArtistTableViewController: UITableViewDataSource, UITableViewDelegate {
  
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return self.beaconRegionViewModel.getNumberOfRows()
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    
    let artist = self.beaconRegionViewModel.selectedArtistList[indexPath.row]
    let dequeued = tableView.dequeueReusableCell(withIdentifier: "ArtistCell", for: indexPath)
    let cell = dequeued as! ArtistTableViewCell
    
    cell.configureCell(artist: artist)
    
    return cell
  }
  
  func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    beaconRegionViewModel.setSelectedArtist(indexPath: indexPath)
    performSegue(withIdentifier: "artistDetail", sender: nil)
  }
  
  func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
    return 110
  }
}
