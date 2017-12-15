//
//  ArtistTableViewController.swift
//  MoonlightCafeDemo
//
//  Created by Jason Custodio on 12/14/17.
//  Copyright © 2017 Jason Custodio. All rights reserved.
//

import UIKit

class ArtistTableViewController: UITableViewController {
  
  @IBOutlet weak var artistTableView: UITableView!
  
  var selectedArtist: Artist?
  
  override func viewDidLoad() {
    super.viewDidLoad()
  }
  
  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
  }
  
  override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return appDelegate.artist.count
  }
  
  override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    
    let artist = appDelegate.artist[indexPath.row]
    let dequeued = tableView.dequeueReusableCell(withIdentifier: "ArtistCell", for: indexPath)
    let cell = dequeued as! ArtistTableViewCell
    
    cell.setArtist(artist: artist)
    
    return cell
  }
  
  override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    let artist = appDelegate.artist[indexPath.row]
    
    selectedArtist = artist
    
    performSegue(withIdentifier: "artistDetail", sender: nil)
  }
  
  override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
    
    let artistController = segue.destination as! ArtistViewController
    
    artistController.artist = selectedArtist
  }
  
}
