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
    
    @IBOutlet weak var announcement: UILabel!
    @IBOutlet weak var tourDescription: UILabel!
    @IBOutlet weak var tourOptionSegmentedControl: UISegmentedControl!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        updateViewForSegment(0)
        
        //NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(self.onLocUpdate(_:)), name: GlobalNotificationKeys.locationUpdate, object: nil)
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
            MainModel.hunt = ScavengerHunt(allProjects: MainModel.projects, projectCount: 5)

        
            let vc = self.storyboard!.instantiateViewControllerWithIdentifier("scavengerHuntViewController") as! ScavengerHuntViewController
            presentViewController(vc, animated: false, completion: nil)
        }
        
        //calculateDirections()
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        //Set up the scavenger hunt object here and then save it to the data model
        
    }
    
    //calculates walking directions for all of the routes in the tour
    func calculateDirections() {
        if MainModel.hunt == nil { return }
        
        
        for i in 0...MainModel.hunt!.projects.projectData.count - 1 {
            
        
        let request: MKDirectionsRequest = MKDirectionsRequest()
        
            if i == 0 {

          //       request.source = MKMapItem(placemark: MKPlacemark(coordinate: USER LOCATION, addressDictionary: nil))
            }
            else {
                request.source = MainModel.hunt!.projects.projectData[i-1].mapItem
            }
        request.destination = MainModel.hunt!.projects.projectData[i].mapItem
        request.requestsAlternateRoutes = true
        request.transportType = .Walking
        
        let directions = MKDirections(request: request)
        directions.calculateDirectionsWithCompletionHandler ({(response: MKDirectionsResponse?, error: NSError?) in
            if let routeResponse = response?.routes {
                let quickestRouteForSegment: MKRoute =
                    routeResponse.sort({$0.expectedTravelTime <
                        $1.expectedTravelTime})[0]
                
                if i == 0 {
                    MainModel.hunt!.routes = [quickestRouteForSegment]
                    MainModel.hunt!.timeEstimate = quickestRouteForSegment.expectedTravelTime as NSTimeInterval!
                }
                else {
                MainModel.hunt!.routes.append(quickestRouteForSegment)
                MainModel.hunt!.timeEstimate = MainModel.hunt!.timeEstimate + quickestRouteForSegment.expectedTravelTime as NSTimeInterval!
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
    }

}
