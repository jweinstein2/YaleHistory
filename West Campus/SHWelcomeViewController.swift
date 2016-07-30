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
    
    var stage: Int!
    
    @IBOutlet weak var announcement: UILabel!
    @IBOutlet weak var tag1: UILabel!
    @IBOutlet weak var tag2: UILabel!

    @IBOutlet weak var projectCountSlider: UISlider! //No connection

    @IBOutlet weak var randomLabel: UILabel! //No connection

    @IBOutlet weak var next: UIButton!
    @IBOutlet weak var previous: UIButton!
    @IBOutlet weak var directions: UILabel!
    @IBOutlet weak var vertStackView: UIStackView!
    @IBOutlet weak var randomSwitch: UISwitch! //This has no connection
    @IBOutlet weak var hoStack4: UIStackView! //This has no connection
    @IBOutlet weak var buttonHoStack: UIStackView!
    @IBOutlet weak var projCount: UILabel!
    @IBOutlet weak var timeEstimate: UILabel!
    @IBOutlet weak var banner1: UIImageView!
    @IBOutlet weak var banner2: UIImageView!

    @IBOutlet weak var banner4: UIImageView! //This has no connection
    @IBOutlet weak var backToMainButton: UIButton!
    
    //Add label and switch for randomized
    
    override func viewDidLoad() {
        super.viewDidLoad()
        stage = 0
        vertStackView.spacing = 10
        hoStack4.spacing = 40
        buttonHoStack.spacing = 40
        tag1.text = "How many residential colleges would you like to see?"
        tag2.text = "Would you like to see the two new colleges under construction?"
        projectCountSlider.maximumValue = 14.0
        projectCountSlider.setValue(14.0, animated: false)
        setStage(true)
        
        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(self.onLocUpdate(_:)), name: GlobalNotificationKeys.locationUpdate, object: nil)
        
        updateProjCount()
    }
    
    override func viewWillAppear(animated: Bool) {
        if (MainModel.scavengerHuntIsSetUp == true){
            self.dismissViewControllerAnimated(false, completion: nil);
        }
        if MainModel.hunt != nil {
            if (MainModel.hunt.progress == -1){
                self.dismissViewControllerAnimated(false, completion: nil);
                MainModel.hunt.progress = 0
            }
        }
        
    }
    
    @IBAction func switchFlipped(sender: AnyObject) {
        updateProjCount()
    }
    
    @IBAction func backButtonPressed(sender: AnyObject) {
        self.dismissViewControllerAnimated(false, completion: nil);
    }
    
    @IBAction func previousButtonPressed(sender: AnyObject) {
        stage = 0
        setStage(true)
    }
    
    @IBAction func nextbuttonPressed(sender: AnyObject) {
        if stage == 0{
            setStage(false)
            stage = 1
        }
        else if (updateProjCount() == 0) { //if they selected no projects, send error
            announcement.text = "Sorry, please select at least one tag to move forward"
        }
        else {
            MainModel.hunt = ScavengerHunt(allProjects: MainModel.projects, projectCount: Int(projectCountSlider.value))
            MainModel.scavengerHuntIsSetUp = true
        
            let vc = self.storyboard!.instantiateViewControllerWithIdentifier("scavengerHuntViewController") as! ScavengerHuntViewController
            presentViewController(vc, animated: false, completion: nil)
        }
        
        calculateDirections()
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
        
        if nearProj == nil { self.nearestProject = nil }
        
        if nearProj!.distanceToUser <= self.thresholdDistance {
            //if nearProj != self.nearestProject { //TODO: Test whether project is replaced with itself
            self.nearestProject = nearProj
            //}
        } else {
            self.nearestProject = nil
        }
    }

    
    func setStage(stageIs0: Bool){
        tag1.hidden = stageIs0
        tag2.hidden = stageIs0
        randomLabel.hidden = stageIs0
        projectCountSlider.hidden = stageIs0
        randomSwitch.hidden = stageIs0
        previous.hidden = stageIs0
        projCount.hidden = stageIs0
        timeEstimate.hidden = stageIs0
        banner1.hidden = stageIs0
        banner2.hidden = stageIs0
        banner4.hidden = stageIs0
        banner4.sendSubviewToBack(self.view)
        backToMainButton.hidden = stageIs0
        
        directions.hidden = !stageIs0
        
        if stageIs0 {
            announcement.text = "Welcome to the Scavenger Hunt!"
        }
        else{
            announcement.text = "I want to see projects that relate to:"
        }
    }
    
    func updateProjCount() -> Int{
        let projectCount : Int = Int(projectCountSlider.value)
        projCount.text = String(format: "Projects to be Found: %d", projectCount)
        timeEstimate.text = String(format: "Time Estimate: %d min", projectCount*5)
        
        return projectCount
    }
    
    
    //calculates walking directions for all of the routes in the tour
    func calculateDirections() {
        
        for i in 0...MainModel.hunt.projects.projectData.count-1 {
            
        
        let request: MKDirectionsRequest = MKDirectionsRequest()
        
            if i == 0 {

          //       request.source = MKMapItem(placemark: MKPlacemark(coordinate: USER LOCATION, addressDictionary: nil))
            }
            else {
                request.source = MainModel.hunt.projects.projectData[i-1].mapItem
            }
        request.destination = MainModel.hunt.projects.projectData[i].mapItem
        request.requestsAlternateRoutes = true
        request.transportType = .Walking
        
        let directions = MKDirections(request: request)
        directions.calculateDirectionsWithCompletionHandler ({(response: MKDirectionsResponse?, error: NSError?) in
            if let routeResponse = response?.routes {
                let quickestRouteForSegment: MKRoute =
                    routeResponse.sort({$0.expectedTravelTime <
                        $1.expectedTravelTime})[0]
                
                if i == 0 {
                    MainModel.hunt.routes = [quickestRouteForSegment]
                    MainModel.hunt.timeEstimate = quickestRouteForSegment.expectedTravelTime as NSTimeInterval!
                }
                else {
                MainModel.hunt.routes.append(quickestRouteForSegment)
                MainModel.hunt.timeEstimate = MainModel.hunt.timeEstimate + quickestRouteForSegment.expectedTravelTime as NSTimeInterval!
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
