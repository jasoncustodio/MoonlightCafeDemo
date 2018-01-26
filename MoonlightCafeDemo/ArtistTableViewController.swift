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
  
  var selectedArtist: Artist?
  var selectedArtistList: [Artist] = []
  
  @IBAction func unwindSegue(_ sender: UIStoryboardSegue) {
    
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    artistTableView.delegate = self
    artistTableView.dataSource = self
  }
  
  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)
    self.selectedArtistList = appDelegate.beaconManager.fetchArtistList()
    artistTableView.reloadData()
  }
  
  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
  }
  
  override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
    
    if segue.identifier == "artistDetail" {
      let artistController = segue.destination as! ArtistViewController
      artistController.artist = selectedArtist
    }
  }
  
}

extension ArtistTableViewController: UITableViewDataSource, UITableViewDelegate {
  
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return selectedArtistList.count
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    
    let artist = selectedArtistList[indexPath.row]
    let dequeued = tableView.dequeueReusableCell(withIdentifier: "ArtistCell", for: indexPath)
    let cell = dequeued as! ArtistTableViewCell
    
    cell.setArtist(artist: artist)
    
    return cell
  }
  
  func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    let artist = selectedArtistList[indexPath.row]
    
    selectedArtist = artist
    
    performSegue(withIdentifier: "artistDetail", sender: nil)
  }
  
  func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
    return 110
  }
}
