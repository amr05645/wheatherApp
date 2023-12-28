//
//  EndPoint.swift
//  WheatherApp
//
//  Created by Amr Hassan on 28/12/2023.
//

import Foundation

enum EndPoint {
    case wheather
    
    
  private var path: String {
      switch self {
      case .wheather:
          return "/current.json"
      }
    }
    
    var fullPath: String {
        Constants.apiBaseUrl + path
    }
}
