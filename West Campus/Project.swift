//
//  Project.swift
//  West Campus
//
//  Created by jared weinstein on 11/5/15.
//  Copyright © 2015 ENAS118. All rights reserved.
//
import UIKit

class Project {
    var projectId: String
    var title: String
    var summary: String
    var link: String
    var gpsLatitude: Double
    var gpsLongitude: Double
    var clue: String
    var action: String?
    var distanceToUser : Double? //Tom could you please update this so everyproject as an constantly updating distance...
    var imageLink : String?
    
    init(projectId: String, title: String, summary: String, link: String, gpsLatitude: Double, gpsLongitude: Double, clue: String, action: String?, imageLink: String){
        self.projectId = projectId
        self.title = title
        self.summary = summary
        self.link = link
        self.gpsLatitude = gpsLatitude
        self.gpsLongitude = gpsLongitude
        self.clue = clue
        self.action = action
        distanceToUser =  Double(random() % 100) /  5.0 //Distance in meters. This is just a default. It eventually needs to be calculated everytime.
        self.imageLink = imageLink //"http://www.planwallpaper.com/static/images/Winter-Tiger-Wild-Cat-Images.jpg"
    }
}