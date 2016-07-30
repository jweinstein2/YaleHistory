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
    let basicTourCount = 5
    let fullTourCount = 14
    
    @IBOutlet weak var announcement: UILabel!
    @IBOutlet weak var tag1: UILabel!
    @IBOutlet weak var tag2: UILabel!



    @IBOutlet weak var next: UIButton!
    @IBOutlet weak var previous: UIButton!
    @IBOutlet weak var directions: UILabel!
    @IBOutlet weak var vertStackView: UIStackView!
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
        setStage(true)
        
        var basicHunt = ScavengerHunt(allProjects: MainModel.projects, projectCount: basicTourCount)
        basicHunt = calculateDirections(basicHunt)
        
        var fullHunt = ScavengerHunt(allProjects: MainModel.projects, projectCount: fullTourCount)
        fullHunt = calculateDirections(fullHunt)
        
        
        
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
        else {
            
            
            //MainModel.hunt = decide which hunt to use
            
            let vc = self.storyboard!.instantiateViewControllerWithIdentifier("scavengerHuntViewController") as! ScavengerHuntViewController
            presentViewController(vc, animated: false, completion: nil)
        }
        
    }

    //calculate directions for the entire hunt
    func calculateDirections(hunt: ScavengerHunt) -> ScavengerHunt {
        
        for i in 0...hunt.projects.projectData.count-1 {
            
            
            let request: MKDirectionsRequest = MKDirectionsRequest()
            
            if i == 0 {
                request.source = MKMapItem(placemark: MKPlacemark(coordinate: LocationUtil.lastLocation!.coordinate, addressDictionary: nil))
            }
            else {
                request.source = hunt.projects.projectData[i-1].mapItem
            }
            request.destination = hunt.projects.projectData[i].mapItem
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

    func setStage(stageIs0: Bool){
        tag1.hidden = stageIs0
        tag2.hidden = stageIs0
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

}
