//
//  Utility.swift
//  Yale History
//
//  Created by jared weinstein on 8/27/16.
//  Copyright © 2016 ENAS118. All rights reserved.
//

import Foundation
import UIKit

enum PhoneType: UInt {
    case iPhone4
    case iPhone5
    case iPhone6
    case iPhone6Plus
    case unknown
}

class Utility {
    class func currentPhone() -> PhoneType {
        if UIDevice().userInterfaceIdiom == .Phone {
            switch UIScreen.mainScreen().nativeBounds.height {
            case 960:
                return .iPhone4
            case 1136:
                return .iPhone5
            case 1334:
                return .iPhone6
            case 2208:
                return .iPhone6Plus
            default:
                return .unknown
            }
        }
        return .unknown
    }
}
