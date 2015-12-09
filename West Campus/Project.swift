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
    var contributors: String
    var imageLink : String
    var innovations: Bool
    var ecology: Bool
    var health: Bool
    var radius: Int

    
    init(projectId: String, title: String, summary: String, link: String, gpsLatitude: Double, gpsLongitude: Double, clue: String, action: String, contributors: String, imageLink: String, innovations: Bool, ecology: Bool, health: Bool, radius: Int){
        self.projectId = projectId
        self.title = title
        self.summary = summary
        self.link = link
        self.gpsLatitude = gpsLatitude
        self.gpsLongitude = gpsLongitude
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