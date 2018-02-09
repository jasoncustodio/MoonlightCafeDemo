//
//  APICall.swift
//  MoonlightCafeDemo
//
//  Created by Jason Custodio on 1/18/18.
//  Copyright © 2018 Jason Custodio. All rights reserved.
//

import Foundation

class NetworkController {
  
  // MARK: - Properties
  static let urlString = "https://moonlight-coffeehouse-api.herokuapp.com/beacons/"
  
  func getBeaconData(completion: @escaping ([[String:Any]]) -> Void) {
    
    guard let request = getRequest(url: NetworkController.urlString) else { return }
    
    sendRequest(request: request) { (data) in
      guard let parsedData = data else { return }
      completion(parsedData)
    }
  }
  
  // MARK: - Helper Functions
  func sendRequest(request: URLRequest?, completion: @escaping ([[String:Any]]?) -> Void) {
    
    let session = URLSession.shared
    
    let task = session.dataTask(with: request!) { (data, response, error) in
      
      guard let unwrappedData = self.unwrapData(data: data, error: error) else {
        completion(nil)
        return
      }
      
      guard let parsedData = self.parseJSON(data: unwrappedData) else {
        completion(nil)
        return
      }
      
      completion(parsedData)
    }
    task.resume()
  }
  
  func unwrapData(data: Data?, error: Error?) -> Data?{
    
    guard error == nil else {
      print("Error: \(error)")
      return nil
    }
    
    guard let unwrappedData = data else {
      print("Error: Unwrapping Data")
      return nil
    }
    
    return unwrappedData
  }
  
  func getRequest(url: String) -> URLRequest? {
    
    let url = URL(string: url)
    guard let unwrappedURL = url else {
      print("Error: Unwrapping URL")
      return nil
    }
    
    return URLRequest(url: unwrappedURL)
  }
  
  func parseJSON(data: Data) -> [[String:Any]]? {
    
    do {
      let json = try JSONSerialization.jsonObject(with: data, options: .mutableContainers) as? [[String:Any]]
      return json
    } catch {
      print(error.localizedDescription)
    }
    return nil
  }
  
}
