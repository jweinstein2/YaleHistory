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
    static var lastLocation : CLLocation?
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
        LocationUtil.lastLocation = currentLoc
        print("did update location to \(String(currentLoc))")
        
        LocationUtil.lastLocation = currentLoc
        
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
    
    
    func locationManager(manager: CLLocationManager, didChangeAuthorizationStatus status: CLAuthorizationStatus) {
        
        switch status {
        case .NotDetermined:
            // If status has not yet been determied, ask for authorization
            break
        case .AuthorizedWhenInUse:
            // If authorized when in use
            break
        case .AuthorizedAlways:
            // If always authorized
            break
        case .Restricted:
            // If restricted by e.g. parental controls. User can't enable Location Services
            break
        case .Denied:
            // If user denied your app access to Location Services, but can grant access from Settings.app
            break
        default:
            break
        }
        
        NSNotificationCenter.defaultCenter().postNotificationName(GlobalNotificationKeys.locationPermissionStatusChange, object: nil)
    }
}
