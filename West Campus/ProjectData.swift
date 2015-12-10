//
//  ProjectData.swift
//  West Campus
//
//  Created by Tom Chu on 11/7/15.
//  Copyright © 2015 ENAS118. All rights reserved.
//

import UIKit

class ProjectData: NSObject {
    var projectData = [Project]()
    
    override init() {
    }
    
    init(var inputString: String){
        super.init()
        
        if inputString != "" {
            
        inputString = inputString.substringToIndex(inputString.endIndex.predecessor())    
        inputString = inputString.stringByReplacingOccurrencesOfString("\\/", withString: "/")
        
        var projectArr = inputString.componentsSeparatedByString("}")
        projectArr.removeLast() //remove bc separating by end braces leaves an empty string at the end
        
        for var index = 0; index < projectArr.count; ++index{
            projectArr[index] = projectArr[index].substringFromIndex(projectArr[index].startIndex.advancedBy(2))
            let id = find(projectArr[index], element: "project_id")
            let title = find(projectArr[index], element: "title")
            let summary = find(projectArr[index], element: "summary")
            let link = find(projectArr[index], element: "link")
            let gpsLatitude : Double! = Double(find(projectArr[index], element: "gps_latitude"))
            let gpsLongitude : Double! = Double(find(projectArr[index], element: "gps_longitude"))
            let clue = find(projectArr[index], element: "clue")
            let action = find(projectArr[index], element: "action")
            let imageLink = find(projectArr[index], element: "photo")
            let radius = Int(find(projectArr[index], element: "radius"))
            let contributors = find(projectArr[index], element: "contributors")
            
            let innovations: Bool
            let ecology: Bool
            let health: Bool
            
            if find(projectArr[index], element: "innovations") == "1" {
                innovations = true
            }
            else{
                innovations = false
            }
            if find(projectArr[index], element: "ecology") == "1" {
                ecology = true
            }
            else{
                ecology = false
            }
            if find(projectArr[index], element: "health") == "1" {
                health = true
            }
            else{
                health = false
            }

            //Need to handle errors if this doens't load or if certain elements arent there. We want to download as much data as possible
            let currentProject = Project.init(projectId: id, title: title, summary: summary, link: link, gpsLatitude: gpsLatitude, gpsLongitude: gpsLongitude, clue: clue, action: action, contributors: contributors, imageLink: imageLink, innovations: innovations, ecology: ecology, health: health, radius: radius!)
            
            projectData.append(currentProject)
            }
        }
        
    }
    
    func find (let project: String, element: String) -> String{
        var tokens = project.componentsSeparatedByString("\",\"")
        
        for var index = 0; index < tokens.count; ++index{
            
            var map = tokens[index].componentsSeparatedByString("\":\"")
            if map[0] == element {
                return map[1]
            }
        }
        return "fail"
    }
}