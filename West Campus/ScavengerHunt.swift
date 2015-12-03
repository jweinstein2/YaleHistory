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
    var isSetUp: Bool!
    
    override init(){
        NSLog("Error: please use custom initializer")
    }
    
    init(allProjects: ProjectData){
        super.init()
    }
}
