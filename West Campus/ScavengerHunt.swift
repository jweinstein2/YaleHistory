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
    var routes = [MKRoute]()
    var transition = false
    var timeEstimate: NSTimeInterval? {
        didSet{
            NSLog("DID SET TIME ESTIMATE")
            //Or do delegate method
            //Send out notification that timeEstimate for a project has been updated
        }
    }
    
    var currentProject : Project {
        return projects[progress]
    }

    //Initializer adds the nearest project and (n-1) projects in the loop
    //TODO: This needs testing :)
    init(destinations: [Project]){
        super.init()
        
        projects = destinations
        progress = 0
        transition = false
        calculateDirections() //This is currently broken
    }
    
    
    //calculate directions for the entire hunt
    func calculateDirections() -> NSTimeInterval? {
        NSLog("CALCULATED DIRECTIONS")
        for i in 0...projects.count-1 {
            
            
            let request: MKDirectionsRequest = MKDirectionsRequest()
            
            if i == 0 {
                request.source = MKMapItem(placemark: MKPlacemark(coordinate: LocationUtil.lastLocation!.coordinate, addressDictionary: nil))
            }
            else {
                request.source = projects[i-1].mapItem
            }
            request.destination = projects[i].mapItem
            request.requestsAlternateRoutes = true
            request.transportType = .Any
            
            let directions = MKDirections(request: request)
            directions.calculateDirectionsWithCompletionHandler ({(response: MKDirectionsResponse?, error: NSError?) in
                if let routeResponse = response?.routes {
                    let quickestRouteForSegment: MKRoute =
                        routeResponse.sort({$0.expectedTravelTime <
                            $1.expectedTravelTime})[0]
                    
                    if i == 0 {
                        self.routes = [quickestRouteForSegment]
                        self.timeEstimate = quickestRouteForSegment.expectedTravelTime as NSTimeInterval!
                    }
                    else {
                        self.routes.append(quickestRouteForSegment)
                        self.timeEstimate = (self.timeEstimate ?? 0) + quickestRouteForSegment.expectedTravelTime as NSTimeInterval!
                    }
                    
                } else if let error = error {
                    //If the directions fail to load
                    NSLog("Error loading directions : \(error)")
                }
            })
        }
        return timeEstimate
    }
}
