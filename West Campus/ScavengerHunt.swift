//
//  ScavengerHunt.swift
//  West Campus
//
//  Created by Tom Chu on 12/3/15.
//  Copyright © 2015 ENAS118. All rights reserved.
//

import UIKit
import MapKit

class ScavengerHunt: NSObject {
    var projects: [Project] = []
    var progress = 0 //Represents the index of the currentProject
    var routes: [MKRoute]!
    var timeEstimate: NSTimeInterval!
    var transition: Bool!
    
    var currentProject : Project {
        return projects[progress]
    }

    //Initializer adds the nearest project and (n-1) projects in the loop
    //TODO: This needs testing :)
    init(destinations: [Project], projectCount: Int){
        super.init()
        
        //find closest project, start from there
        var minDist : Double = -1
        var closeId : Int = -1
        for project in destinations {
            if project.projectId == "1" {
                minDist = project.distanceToUser!
                closeId = Int(project.projectId)!
            }
            else if project.distanceToUser < minDist {
                minDist = project.distanceToUser! //This could be nil and crash
                //if LocationUtil.lastLocation == nil then we havent gotten location data yeete
                closeId = Int(project.projectId)!
            }
        }
        
        closeId -= 1                    //avoids off by one error below
        let projectCountMinus = projectCount - 1 //avoids off by one error below
        
        for index in closeId...(closeId + projectCountMinus) {
            let i = index % destinations.count
            
            let upperBound = (closeId + projectCountMinus) % destinations.count
            
            if (closeId + projectCountMinus) / destinations.count < 1 {
                if i <= upperBound && i >= closeId {
                    projects.append(destinations[i])
                }
            }
            else if i >= closeId || i <= upperBound {
                projects.append(destinations[i])
            }
        }
        
        progress = 0
        transition = false
    }
}
