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
    var action: String
    
    init(projectId: String, title: String, summary: String, link: String, gpsLatitude: Double, gpsLongitude: Double, clue: String, action: String){
        NSLog("printing")
        NSLog(projectId)
        NSLog("printing")
        self.projectId = projectId
        self.title = title
        self.summary = summary
        self.link = link
        self.gpsLatitude = gpsLatitude
        self.gpsLongitude = gpsLongitude
        self.clue = clue
        self.action = action
    }
}