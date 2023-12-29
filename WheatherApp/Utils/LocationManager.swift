//
//  LocationManager.swift
//  WheatherApp
//
//  Created by Amr Hassan on 29/12/2023.
//

import Foundation
import CoreLocation

class LocationManager {
    let locationManager = CLLocationManager()
    var currentLocation: CLLocation?
    
    func requestLocationPermission() {
        locationManager.requestWhenInUseAuthorization()
    }
    
    func getCurrentLocation() {
        locationManager.startUpdatingLocation()
        currentLocation = locationManager.location
    }
}
