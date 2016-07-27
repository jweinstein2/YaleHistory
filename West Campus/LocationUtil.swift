//
//  LocationUtil.swift
//  West Campus
//
//  Created by jared weinstein on 7/17/16.
//  Copyright © 2016 ENAS118. All rights reserved.
//

import Foundation
import CoreLocation


class LocationUtil : NSObject, CLLocationManagerDelegate {
    static let sharedInstance = LocationUtil()
    
    let manager = CLLocationManager()
    
    func setup (){
        handleLocationPermissions()
        manager.delegate = self
        manager.desiredAccuracy = kCLLocationAccuracyBestForNavigation
        manager.distanceFilter = 1
        manager.startUpdatingLocation()
    }
    
    private func handleLocationPermissions(){
        //TODO: Handle the different cases resulting from this
        if CLLocationManager.authorizationStatus() == .NotDetermined {
            self.manager.requestWhenInUseAuthorization()
        }
    }

    func locationManager(manager: CLLocationManager, didUpdateLocations locations: [CLLocation]){
        let currentLoc = locations.last!
        print("did update location to \(String(currentLoc))")
        
        NSNotificationCenter.defaultCenter().postNotificationName(GlobalNotificationKeys.locationUpdate, object: currentLoc)
    }
    
    func locationManager(manager: CLLocationManager, didFailWithError error: NSError) {
        NSLog("Location Manager Failed" )
    }
    
    static func isLocationAvailable() -> Bool {
        if CLLocationManager.locationServicesEnabled() {
            switch(CLLocationManager.authorizationStatus()) {
            case .NotDetermined, .Restricted, .Denied:
                //print("No access")
                return false
            case .AuthorizedAlways, .AuthorizedWhenInUse:
                //print("Access")
                return true
            }
        } else {
            //print("Location services are not enabled")
            return false
        }
    }
}
