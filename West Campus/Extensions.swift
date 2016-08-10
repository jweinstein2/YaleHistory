//
//  Extensions.swift
//  Yale History
//
//  Created by jared weinstein on 7/21/16.
//  Copyright © 2016 ENAS118. All rights reserved.
//

import Foundation
import CoreLocation
import UIKit

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

extension UIButton {
    private func actionHandleBlock(action:(() -> Void)? = nil) {
        struct __ {
            static var action :(() -> Void)?
        }
        if action != nil {
            __.action = action
        } else {
            __.action?()
        }
    }
    
    @objc private func triggerActionHandleBlock() {
        self.actionHandleBlock()
    }
    
    func actionHandle(controlEvents control :UIControlEvents, ForAction action:() -> Void) {
        self.actionHandleBlock(action)
        self.addTarget(self, action: #selector(UIButton.triggerActionHandleBlock), forControlEvents: control)
    }
}

