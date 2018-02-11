//
//  Extensions.swift
//  MoonlightCafeDemo
//
//  Created by Jason Custodio on 12/18/17.
//  Copyright © 2017 Jason Custodio. All rights reserved.
//

import UIKit
import Foundation
import UserNotifications

extension UIViewController {
  
  // Allow all views to segue to artistList after notification action
  func artistListSegue() {
    performSegue(withIdentifier: "artistList", sender: nil)
  }
  
}

extension UIImageView {
  func downloadedFrom(url: URL, contentMode mode: UIViewContentMode = .scaleAspectFit) {
    contentMode = mode
    URLSession.shared.dataTask(with: url) { data, response, error in
      guard
        let httpURLResponse = response as? HTTPURLResponse, httpURLResponse.statusCode == 200,
        let mimeType = response?.mimeType, mimeType.hasPrefix("image"),
        let data = data, error == nil,
        let image = UIImage(data: data)
        else { return }
      DispatchQueue.main.async() {
        self.image = image
      }
      }.resume()
  }
  func downloadedFrom(link: String, contentMode mode: UIViewContentMode = .scaleAspectFit) {
    guard let url = URL(string: link) else { return }
    downloadedFrom(url: url, contentMode: mode)
  }
}
