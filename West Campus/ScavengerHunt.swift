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
    var projects: ProjectData!
    var progress = 0
    var routes: [MKRoute]!
    var timeEstimate: NSTimeInterval!
    var transition: Bool!
    
    override init(){
        NSLog("Error: please use custom initializer")
    }


    
    init(allProjects: ProjectData, projectCount: Int){
        super.init()
        
        projects = ProjectData()
        
        //find closest project, start from there
        var minDist : Double = -1
        var closeId : Int = -1
        for project in allProjects.projectData {
            
            
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
            let i = index % allProjects.projectData.count
            
            let upperBound = (closeId + projectCountMinus) % allProjects.projectData.count
            
            if (closeId + projectCountMinus) / allProjects.projectData.count < 1 {
                if i <= upperBound && i >= closeId {
                    projects.projectData.append(MainModel.projects.projectData[i])
                }
            }
            else if i >= closeId || i <= upperBound {
                projects.projectData.append(MainModel.projects.projectData[i])
            }
        }
        
        
        /* No need for random functionality
        if random {
            for var index = projects.projectData.count - 1; index > 0; index -= 1
            {
                // Random int from 0 to index-1
                let j = Int(arc4random_uniform(UInt32(index-1)))
                
                //swap current project and a random one
                swap(&projects.projectData[index], &projects.projectData[j])
            }
            
            //NOTE: code for this shuffle was taken from http://iosdevelopertips.com/swift-code/swift-shuffle-array-type.html
        }
        */
        
        
        progress = 0
        transition = false
    }
    
    init (projects: [Project]){
        
    }
}
