//
//  APICall.swift
//  MoonlightCafeDemo
//
//  Created by Jason Custodio on 1/18/18.
//  Copyright © 2018 Jason Custodio. All rights reserved.
//

import Foundation

class APICall {
  
  func getBeaconData() {
    
    let beaconURL = URL(string: "https://moonlight-coffeehouse-api.herokuapp.com/beacons/")
    
    
    let session = URLSession.shared
    
    session.dataTask(with: beaconURL!) { (data: Data?, response: URLResponse?, error: Error?) in
      guard let data = data else {
        //completion(nil)
        return
      }
      
      guard let json = try? JSONSerialization.jsonObject(with: data, options: .mutableContainers) // as? [String:Any]
      else {
        return
      }
     
      print (json)
      
    }.resume()
  }
  
}
