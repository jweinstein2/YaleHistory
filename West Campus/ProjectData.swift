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
    
    init(let inputArray: NSArray){
        super.init()
        
        NSLog(String(inputArray[0] as! NSDictionary)) //This shows that the input array is filled correctly (This just prints out the data for the first project)
        
        if inputArray != "" {
            
        for var i = 0; i < inputArray.count; i++ {
            let jsonElement : NSDictionary = inputArray[i] as! NSDictionary;
            let id = String(jsonElement.objectForKey("id") as! String)
            let title = String(jsonElement.objectForKey("title")as! String)
            let summary = String(jsonElement.objectForKey("summary")as! String)
            let link = String(jsonElement.objectForKey("link")as! String)
            let gpsLatitude = String(jsonElement.objectForKey("gps_latitude")as! String)
            let gpsLongitude = String(jsonElement.objectForKey("gps_longitude")as! String)
            let clue = String(jsonElement.objectForKey("clue")as! String)
            let action = String(jsonElement.objectForKey("action")as! String)
            let imageLink = String(jsonElement.objectForKey("photo")as! String)
            let radius = String(jsonElement.objectForKey("radius")as! String)
            let contributors = String(jsonElement.objectForKey("contributors")as! String)
            
            let innovations: Bool
            let ecology: Bool
            let health: Bool
            
            if String(jsonElement.objectForKey("innovation")as! String) == "1" {
                innovations = true
            }
            else{
                innovations = false
            }
            if String(jsonElement.objectForKey("ecology")as! String) == "1" {
                ecology = true
            }
            else{
                ecology = false
            }
            if String(jsonElement.objectForKey("health")as! String) == "1" {
                health = true
            }
            else{
                health = false
            }
            
            //These are either not working or have a weird Optional(...) thing around them... See the console output
            
            NSLog(String(id))
             NSLog(String(title))
             NSLog(String(summary))
             NSLog(String(gpsLatitude))
             NSLog(String(gpsLongitude))
             NSLog(String(clue))
            
             NSLog(String(action))
             NSLog(String(contributors))
             NSLog(String(imageLink))
             NSLog(String(innovations))
             NSLog(String(ecology))
             NSLog(String(health))
             NSLog(String(radius))
            
            
            //Need to handle errors if this doens't load or if certain elements arent there. We want to download as much data as possible
            let currentProject = Project.init(projectId: id, title: title, summary: summary, link: link, gpsLatitude: Double(gpsLatitude)!, gpsLongitude: Double(gpsLongitude)!, clue: clue, action: action, contributors: contributors, imageLink: imageLink, innovations: innovations, ecology: ecology, health: health, radius: Int(radius)!)
            
            projectData.append(currentProject)
        }
            
        /*
        
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
            
            if find(projectArr[index], element: "innovation") == "1" {
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

    */
            
        }
        
    }
    
    /*
    
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
*/
}