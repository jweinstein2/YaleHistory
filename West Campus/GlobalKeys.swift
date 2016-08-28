//
//  GlobalKeys.swift
//  West Campus
//
//  Created by jared weinstein on 7/10/16.
//  Copyright © 2016 ENAS118. All rights reserved.
//

import Foundation
import UIKit

struct vcIdentifiers {
    static let mapVC = "mapViewController"
}

struct GlobalNotificationKeys {
    static let locationUpdate = "on_loc_update"
    static let onNearbyProject = "on_nearby_project"
    static let locationPermissionStatusChange = "on_loc_permission_changed"
    static let noData = "no_location_data"
}

struct ThemeColors {
    static let lightMapBlue = UIColor(red: (87/255), green: (213/255), blue: (255/255), alpha: 1)
}