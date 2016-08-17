//
//  ProjectData.swift
//  West Campus
//
//  Created by Tom Chu on 11/7/15.
//  Copyright © 2015 ENAS118. All rights reserved.
//

import UIKit
import CoreLocation

class ProjectData: NSObject {
    final let thresholdDistance = 50.0 //How close before a project shows up on the home screen
    var projectData = [Project]()
    
    var nearestProject : Project? { //Nearest project within the threshold Distance
        didSet {
            if nearestProject == nil {
                NSNotificationCenter.defaultCenter().postNotificationName(GlobalNotificationKeys.onNearbyProject, object: nil)
            }
            if nearestProject?.distanceToUser < thresholdDistance {
                NSLog("New Nearest Project")
                NSNotificationCenter.defaultCenter().postNotificationName(GlobalNotificationKeys.onNearbyProject, object: nearestProject)
            }
        }
    }
    
    override init() {
    }
    
    func add(let inputArray: NSArray){
        //NSLog(String(inputArray[0] as! NSDictionary)) //This shows that the input array is filled correctly (This just prints out the data for the first project)
        
        if inputArray != "" {
            
            for i in 0 ..< inputArray.count {
                NSLog("doing \(i)")
                let jsonElement : NSDictionary = inputArray[i] as! NSDictionary;
                let id = Int(String(jsonElement.objectForKey("id") as? String ?? "0"))!
                let alphabetical = Int(String(jsonElement.objectForKey("alphabetical") as? String ?? "0"))!
                let title = String(jsonElement.objectForKey("title")as? String ?? "College")
                let link = String(jsonElement.objectForKey("link")as? String ?? "")
                let imageLink = String(jsonElement.objectForKey("photo")as? String ?? "")
                dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_LOW, 0)) {
                    _ = ImageUtil.imageFromURL(imageLink)
                }
                let gpsLatitude = Double(String(jsonElement.objectForKey("gps_latitude")as? String ?? ""))!
                let gpsLongitude = Double(String(jsonElement.objectForKey("gps_longitude")as? String ?? ""))!
                let theBuilding = String(jsonElement.objectForKey("theBuilding")as? String ?? "Information Not Available")
                let theNamesake = String(jsonElement.objectForKey("theNamesake")as? String ?? "Information Not Available")
                let radius = Int(String(jsonElement.objectForKey("radius")as? String ?? "20"))!
                let namesakeName = String(jsonElement.objectForKey("namesakeName")as? String ?? "N/A")
                let collegeWebsite = String(jsonElement.objectForKey("collegeWebsite")as? String ?? "")
                
                let currentProject = Project.init(projectId: id, alphabetical: alphabetical, title: title, link: link, gpsLatitude: gpsLatitude, gpsLongitude: gpsLongitude, theBuilding: theBuilding, theNamesake: theNamesake, imageLink: imageLink, radius: radius, namesakeName: namesakeName, collegeWebsite: collegeWebsite)
                projectData.append(currentProject)
            }
        }
        
        
        
        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(self.onLocUpdate(_:)), name: GlobalNotificationKeys.locationUpdate, object: nil)
    }
    
    func onLocUpdate(notification: NSNotification){
        
        print("updating location")
        //Take Action on Notification
        let userLoc = notification.object as! CLLocation
        
        var nearProj = projectData.first
        
        for project in projectData {
            let distance = project.location.distanceFromLocation(userLoc)
            project.distanceToUser = distance
            if distance < nearProj?.distanceToUser || nearProj == nil {
                nearProj = project
            }
        }
        
        if nearProj == nil { self.nearestProject = nil; return }
        
        if nearProj!.distanceToUser <= self.thresholdDistance {
            //if nearProj != self.nearestProject { //TODO: Test whether project is replaced with itself
                self.nearestProject = nearProj
            //}
        } else {
            self.nearestProject = nil
        }
    }
    
    func nearestProjects(num n : Int) -> [Project]?{
        if LocationUtil.lastLocation == nil {
            return nil
        }
        
        let sortedByDistance = projectData.sort({ $0.distanceToUser < $1.distanceToUser })
        if sortedByDistance.count == 0 {
            return []
        }
        let firstN = sortedByDistance[0]
        
        let closeId = firstN.projectId - 1      //avoids off by one error below
        let projectCountMinus = n - 1 //avoids off by one error below
        var projects : [Project] = []
        
        for index in closeId...(closeId + projectCountMinus) {
            
            let i = index % projectData.count
            
            let upperBound = (closeId + projectCountMinus) % projectData.count
            
            if (closeId + projectCountMinus) / projectData.count < 1 {
                if i <= upperBound && i >= closeId {
                    projects.append(projectData[i])
                }
            }
            else if i >= closeId || i <= upperBound {
                projects.append(projectData[i])
            }
        }
        
        return projects
    }
}