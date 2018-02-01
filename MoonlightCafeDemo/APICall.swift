//
//  APICall.swift
//  MoonlightCafeDemo
//
//  Created by Jason Custodio on 1/18/18.
//  Copyright © 2018 Jason Custodio. All rights reserved.
//

import Foundation

class APICall {
  
  func getBeaconData(completion: @escaping ([[String:Any]]) -> Void) {
    
    let beaconURL = URL(string: "https://moonlight-coffeehouse-api.herokuapp.com/beacons/")
    let session = URLSession.shared
    
    
    let task = session.dataTask(with: beaconURL!) { (data, response, error) in
      
      // Check Error
      guard error == nil else {
        print("Error: \(error)")
        return
      }
      
      // Check Data
      guard let data = data else {
        print("Error: Response Data")
        return
      }
      
      // Convert json into array
      guard let json = try? JSONSerialization.jsonObject(with: data, options: .mutableContainers) as? [[String:Any]]
        else { return }
      
      DispatchQueue.main.async{
        completion(json!)
      }
    }
    task.resume()
  }
  
}
