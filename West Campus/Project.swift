//
//  Project.swift
//  West Campus
//
//  Created by jared weinstein on 11/5/15.
//  Copyright © 2015 ENAS118. All rights reserved.
//
import UIKit
import MapKit
import CoreLocation

class Project {
    //Database Variables
    var projectId: Int
    var alphabetical: Int
    var title: String
    var link: String
    var location: CLLocation
    var mapItem: MKMapItem
    var imageLink : String
    var theBuilding : String
    var theNamesake : String
    var namesakeName : String
    var collegeWebsite : String
    var radius: Int
    
    //Run Time Variables
    var distanceToUser : Double? = nil        //Distance is always stored in meters
    
    init(projectId: Int, alphabetical: Int, title: String, link: String, gpsLatitude: Double, gpsLongitude: Double, theBuilding: String, theNamesake: String, imageLink: String, radius: Int, namesakeName : String, collegeWebsite: String){
        self.projectId = projectId
        self.alphabetical = alphabetical
        self.title = title
        self.link = link
        self.location = CLLocation.init(latitude: gpsLatitude, longitude: gpsLongitude)
        let loc = CLLocationCoordinate2D.init(latitude: gpsLatitude, longitude: gpsLongitude)
        self.mapItem = MKMapItem(placemark: MKPlacemark(coordinate: loc, addressDictionary: nil))
        self.mapItem.name = title
        self.imageLink = imageLink
        self.theBuilding = theBuilding
        self.theNamesake = theNamesake
        self.namesakeName = namesakeName
        self.collegeWebsite = collegeWebsite
        self.radius = radius
    }
}