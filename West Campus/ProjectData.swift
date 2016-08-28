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
    
    func add(let inputArray: [NSDictionary]){
        //NSLog(String(inputArray[0] as! NSDictionary)) //This shows that the input array is filled correctly (This just prints out the data for the first project)
        if inputArray.count != 0 {
            for i in 0 ..< inputArray.count {
                NSLog("doing \(i)")
                let jsonElement = inputArray[i]
                NSLog(String(jsonElement))
                let id = Int(jsonElement.objectForKey("id") as? String ?? "0")
                let alphabetical = Int(jsonElement.objectForKey("print_order") as? String ?? "0")
                let title = jsonElement.objectForKey("title") as? String ?? "College"
                let link = jsonElement.objectForKey("link")as? String ?? ""
                let imageLink = jsonElement.objectForKey("photo") as? String ?? ""
                dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_LOW, 0)) {
                    _ = ImageUtil.imageFromURL(imageLink)
                }
                let gpsLatitude = Double(jsonElement.objectForKey("gps_latitude") as? String ?? "0.0")
                let gpsLongitude = Double(jsonElement.objectForKey("gps_longitude")as? String ?? "0.0")
                let theBuilding = jsonElement.objectForKey("building") as? String ?? "Information Not Available"
                let theNamesake = jsonElement.objectForKey("namesake") as? String ?? "Information Not Available"
                let radius = Int(jsonElement.objectForKey("radius") as? String ?? "25")
                let namesakeName = jsonElement.objectForKey("namesake_name") as? String ?? "N/A"
                let collegeWebsite = jsonElement.objectForKey("link_additional") as? String ?? ""
                
                let currentProject = Project.init(projectId: id!, alphabetical: alphabetical!, title: title, link: link, gpsLatitude: gpsLatitude!, gpsLongitude: gpsLongitude!, theBuilding: theBuilding, theNamesake: theNamesake, imageLink: imageLink, radius: radius!, namesakeName: namesakeName, collegeWebsite: collegeWebsite)
                projectData.append(currentProject)
            }
        }
        projectData.sortInPlace { $0.projectId < $1.projectId }
        
        
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
        
        let closeId = firstN.projectId
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