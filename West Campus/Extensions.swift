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

extension Double {
    func toDistanceString() -> String {
        if self <= 1000 {
            return String(format: "%.1d meters", self)
        } else {
            if self > 100000 {
                return "100+ km"
            }
            return String(format: "%.1d km", self / 1000)
        }
    }
}

extension NSTimeInterval {
    func toString() -> String {
        let formatter = NSDateFormatter()
        formatter.locale = NSLocale.currentLocale()
        formatter.dateFormat = "HH:mm"
        let string = formatter.stringFromDate(NSDate(timeIntervalSinceReferenceDate: self))
        return string
    }
}

