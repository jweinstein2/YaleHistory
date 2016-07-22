//
//  Project.swift
//  West Campus
//
//  Created by jared weinstein on 11/5/15.
//  Copyright © 2015 ENAS118. All rights reserved.
//
import UIKit
import CoreLocation

class Project {
    //Database Variables
    var projectId: String
    var title: String
    var summary: String
    var link: String
    //var gpsLatitude: Double
    //var gpsLongitude: Double
    var location: CLLocation
    var clue: String
    var action: String
    var contributors: String
    var imageLink : String
    var innovations: Bool
    var ecology: Bool
    var health: Bool
    var radius: Int
    
    //Run Time Variables
    let thresholdDistance = 30.0
    var distanceToUser : Double? = nil {        //Distance is always stored in meters
        didSet {
            if distanceToUser < thresholdDistance {
                NSNotificationCenter.defaultCenter().postNotificationName(GlobalNotificationKeys.onNearbyProject, object: self)
            }
        }
    }
    
    init(projectId: String, title: String, summary: String, link: String, gpsLatitude: Double, gpsLongitude: Double, clue: String, action: String, contributors: String, imageLink: String, innovations: Bool, ecology: Bool, health: Bool, radius: Int){
        self.projectId = projectId
        self.title = title
        self.summary = summary
        self.link = link
        self.location = CLLocation.init(latitude: gpsLatitude, longitude: gpsLongitude)
        self.clue = clue
        self.action = action
        self.imageLink = imageLink
        self.contributors = contributors
        self.innovations = innovations
        self.ecology = ecology
        self.health = health
        self.radius = radius
    }
}