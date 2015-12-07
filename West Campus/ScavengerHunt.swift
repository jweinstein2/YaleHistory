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
    
    init(allProjects: ProjectData, tag1: Bool, tag2: Bool, tag3: Bool, random: Bool){
        super.init()
        //SET UP INITIALIZER
        
        projects = allProjects
        progress = 0
        transition = false
    }
}
