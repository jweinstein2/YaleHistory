//
//  ScavengerHunt.swift
//  West Campus
//
//  Created by Tom Chu on 12/3/15.
//  Copyright © 2015 ENAS118. All rights reserved.
//

import UIKit

class ScavengerHunt: NSObject {
    var projects: ProjectData!
    var progress: Int!
    var transition: Bool!
    
    override init(){
        NSLog("Error: please use custom initializer")
    }
    
    init(allProjects: ProjectData, /* forestry: Bool, sustainability: Bool, construction: Bool,*/ random: Bool){
        super.init()
        
        projects = ProjectData()
        
        for var i = 0; i < allProjects.projectData.count; i++ { //adds projects to Hunt if they are tagged
            
            if (true/*(forestry && allProjects.projectData[i].forestry) || (sustainability && allProjects.projectData[i].sustainability) || (construction && allProjects.projectData[i].construction)*/){
                
                projects.projectData.append(allProjects.projectData[i])
            }
        }
        
        if random {
            for var index = projects.projectData.count - 1; index > 0; index--
            {
                // Random int from 0 to index-1
                let j = Int(arc4random_uniform(UInt32(index-1)))
                
                //swap current project and a random one
                swap(&projects.projectData[index], &projects.projectData[j])
            }
            
            //NOTE: code for this shuffle was taken from http://iosdevelopertips.com/swift-code/swift-shuffle-array-type.html
        }
        
        progress = 0
        transition = false
    }
}
