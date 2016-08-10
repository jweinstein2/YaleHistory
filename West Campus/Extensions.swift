//
//  Extensions.swift
//  Yale History
//
//  Created by jared weinstein on 7/21/16.
//  Copyright © 2016 ENAS118. All rights reserved.
//

import Foundation
import CoreLocation

extension Double {
    func toDistanceString() -> String {
        if self <= 1000 {
            return String(format: "%.1f meters", self)
        } else {
            if self > 100000 {
                return "100+ km"
            }
            return String(format: "%.1f km", self / 1000)
        }
    }
}

extension NSTimeInterval {
    func toString() -> String {
        let min = Int(self / 60)
        return "\(min) minutes"
    }
}

