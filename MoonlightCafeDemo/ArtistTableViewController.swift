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
    var selectedArtistList: [Artist] = []
  
    @IBAction func unwindSegue(_ sender: UIStoryboardSegue) {
    
    }
  
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.selectedArtistList = appDelegate.beaconManager.fetchArtistList()
        tableView.reloadData()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return selectedArtistList.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let artist = selectedArtistList[indexPath.row]
        let dequeued = tableView.dequeueReusableCell(withIdentifier: "ArtistCell", for: indexPath)
        let cell = dequeued as! ArtistTableViewCell
        
        cell.setArtist(artist: artist)
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let artist = selectedArtistList[indexPath.row]
        
        selectedArtist = artist
        
        performSegue(withIdentifier: "artistDetail", sender: nil)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "artistDetail" {
            let artistController = segue.destination as! ArtistViewController
            artistController.artist = selectedArtist
        }
    }
    
}
