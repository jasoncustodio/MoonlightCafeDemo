//
//  ArtistTableViewController.swift
//  MoonlightCafeDemo
//
//  Created by Jason Custodio on 12/14/17.
//  Copyright © 2017 Jason Custodio. All rights reserved.
//

import UIKit

class ArtistTableViewController: UIViewController {
  
  // MARK: - Interface Builder
  @IBOutlet weak var artistTableView: UITableView!
  @IBAction func unwindSegue(_ sender: UIStoryboardSegue) { }
  
  // MARK: - Properties
  var beaconRegionViewModel: BeaconRegionViewModel!
  
  // MARK: - Methods
  override func viewDidLoad() {
    super.viewDidLoad()
    artistTableView.delegate = self
    artistTableView.dataSource = self
  }
  
  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)
    DispatchQueue.main.async { self.artistTableView.reloadData() }
  }
  
  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
  }
  
  override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
    guard let identifier = segue.identifier else { return }
    
    switch identifier {
    case "artistDetail":
      let artistController = segue.destination as! ArtistDetailViewController
      artistController.beaconRegionViewModel = self.beaconRegionViewModel
    default: break
    }
  }
}

extension ArtistTableViewController: UITableViewDataSource, UITableViewDelegate {
  
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return self.beaconRegionViewModel.getNumberOfRows()
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    
    let artist = self.beaconRegionViewModel.getArtist(indexPath: indexPath)
    let dequeued = tableView.dequeueReusableCell(withIdentifier: "ArtistCell", for: indexPath)
    let cell = dequeued as! ArtistTableViewCell
    
    cell.configureCell(artist: artist)
    
    return cell
  }
  
  func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    beaconRegionViewModel.setSelectedArtist(indexPath: indexPath)
  }
  
  func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
    return 110
  }
}
