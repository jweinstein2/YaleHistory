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
        NSLog("Error please use the custom initializer")
    }
    
    init(var inputString: String){
        super.init()
        
        inputString = inputString.substringToIndex(inputString.endIndex.predecessor())
        var projectArr = inputString.componentsSeparatedByString("}")
        
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
            //Need to handle errors if this doens't load or if certain elements arent there. We want to download as much data as possible
            let currentProject = Project.init(projectId: id, title: title, summary: summary, link: link, gpsLatitude: gpsLatitude, gpsLongitude: gpsLongitude, clue: clue, action: action)
      
            projectData.append(currentProject)
        }
    }
    
    func find (var project: String, element: String) -> String{
        project = project.stringByReplacingOccurrencesOfString("\"", withString: "")
        var tokens = project.componentsSeparatedByString(",")
        
        for var index = 0; index < tokens.count; ++index{
            NSLog(String(index))
            NSLog(tokens[index])
            if tokens[index] == element {
                return tokens[index+1]
            }
        }
        NSLog("error")
        return "fail"
    }
}