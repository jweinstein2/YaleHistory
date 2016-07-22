//
//  Extensions.swift
//  Yale History
//
//  Created by jared weinstein on 7/21/16.
//  Copyright © 2016 ENAS118. All rights reserved.
//

import Foundation
import CoreLocation

extension CLLocation {
    //returns the distance to another CLLocation in meters
    /*
    func distanceFromLoc(loc: CLLocation) -> Int {
        loc.distance
        let fromLat = self.coordinate.latitude
        let fromLong = self.coordinate.longitude
        let toLat = loc.coordinate.latitude
        let toLong = loc.coordinate.longitude
        let x = 111111*(toLat - fromLat)
        let y = 111111*(toLong - fromLong)
        
        return Int(sqrt(x*x + y*y))
    }
    */
    
}

extension CLLocationDistance {
    func toString() -> String {
        if self <= 1000 {
            return "\(self) meters"
        } else {
            return "\(self / 1000) km"
        }
    }
}
