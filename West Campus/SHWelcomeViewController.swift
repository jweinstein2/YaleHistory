//
//  SHWelcomeViewController.swift
//  West Campus
//
//  Created by Tom Chu on 12/3/15.
//  Copyright © 2015 ENAS118. All rights reserved.
//

import UIKit
import MapKit

class SHWelcomeViewController: MyViewController {
    var selectedProjects : [Project] = []
    var tourData : [(description: String, projectList: [Project])] = [("Take a quick tour of the 5 nearest points of interest", [MainModel.projects.projectData.first!]), ("Embark on a full tour of all 14 colleges and their hidden historical significance", MainModel.projects.projectData)]
    
    let basicTourCount = 5 //Add these two properties to the tourData variable
    let fullTourCount = 14
    
    @IBOutlet weak var announcement: UILabel!
    @IBOutlet weak var tourDescription: UILabel!
    @IBOutlet weak var tourOptionSegmentedControl: UISegmentedControl!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        updateViewForSegment(0)
        
        //var basicHunt = ScavengerHunt(allProjects: MainModel.projects, projectCount: basicTourCount)
        //basicHunt = calculateDirections(basicHunt)
        
        //var fullHunt = ScavengerHunt(allProjects: MainModel.projects, projectCount: fullTourCount)
        //fullHunt = calculateDirections(fullHunt)
        
        //Move this initialization into my TourData variable
        
        
        
    }
    
    override func viewWillAppear(animated: Bool) {
        /*
         if (MainModel.scavengerHuntIsSetUp == true){
         self.dismissViewControllerAnimated(false, completion: nil);
         }
         if MainModel.hunt != nil {
         if (MainModel.hunt.progress == -1){
         self.dismissViewControllerAnimated(false, completion: nil);
         MainModel.hunt.progress = 0
         }
         }
         */
    }
    
    @IBAction func onTourTypeChanged(sender: UISegmentedControl) {
        updateViewForSegment(sender.selectedSegmentIndex)
    }
    
    private func updateViewForSegment(n: Int) {
        tourDescription.text = tourData[n].description
        selectedProjects = tourData[n].projectList
    }
    
    @IBAction func backButtonPressed(sender: AnyObject) {
        self.navigationController?.popViewControllerAnimated(true)
    }
    
    @IBAction func nextbuttonPressed(sender: AnyObject) {
        if (selectedProjects.count == 0) { //if they selected no projects, send error
            //announcement.text = "Sorry, please select at least one tag to move forward"
        }
        else {
            //Set up scavenger hunt and transition appropriately
            MainModel.hunt = ScavengerHunt(destinations: MainModel.projects.projectData, projectCount: 5)
            
            
            let vc = self.storyboard!.instantiateViewControllerWithIdentifier("scavengerHuntViewController") as! ScavengerHuntViewController
            presentViewController(vc, animated: false, completion: nil)
        }
        
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        //Set up the scavenger hunt object here and then save it to the data model
    }
    
    //calculate directions for the entire hunt
    func calculateDirections(hunt: ScavengerHunt) -> ScavengerHunt {
        
        for i in 0...hunt.projects.count-1 {
            
            
            let request: MKDirectionsRequest = MKDirectionsRequest()
            
            if i == 0 {
                request.source = MKMapItem(placemark: MKPlacemark(coordinate: LocationUtil.lastLocation!.coordinate, addressDictionary: nil))
            }
            else {
                request.source = hunt.projects[i-1].mapItem
            }
            request.destination = hunt.projects[i].mapItem
            request.requestsAlternateRoutes = true
            request.transportType = .Walking
            
            let directions = MKDirections(request: request)
            directions.calculateDirectionsWithCompletionHandler ({(response: MKDirectionsResponse?, error: NSError?) in
                if let routeResponse = response?.routes {
                    let quickestRouteForSegment: MKRoute =
                        routeResponse.sort({$0.expectedTravelTime <
                            $1.expectedTravelTime})[0]
                    
                    if i == 0 {
                        hunt.routes = [quickestRouteForSegment]
                        hunt.timeEstimate = quickestRouteForSegment.expectedTravelTime as NSTimeInterval!
                    }
                    else {
                        hunt.routes.append(quickestRouteForSegment)
                        hunt.timeEstimate = hunt.timeEstimate + quickestRouteForSegment.expectedTravelTime as NSTimeInterval!
                    }
                    
                } else if let _ = error {
                    let alert = UIAlertController(title: nil, message: "Directions not available.", preferredStyle: .Alert)
                    let okButton = UIAlertAction(title: "OK", style: .Cancel) { (alert) -> Void in self.navigationController?.popViewControllerAnimated(true)
                    }
                    alert.addAction(okButton)
                    self.presentViewController(alert, animated: true, completion: nil)
                }
            })
        }
        return hunt
    }
}
