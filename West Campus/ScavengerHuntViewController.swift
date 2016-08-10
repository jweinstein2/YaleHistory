//
//  ScavengerHuntViewController.swift
//  West Campus
//
//  Created by jared weinstein on 11/3/15.
//  Copyright © 2015 ENAS118. All rights reserved.
//

import UIKit
import Foundation
import MapKit
import CoreLocation

class ScavengerHuntViewController: MyViewController {
    let scavengerHunt = MainModel.hunt!
    var storyboardtwo : UIStoryboard!
    var vc : MapViewController!
    var mapShown = false
    var currProj: Project!
    let regionRadius = 15.0
    var projectList : [Project]!
    var currentRoute:MKRoute?{
        didSet{
            if currentRoute != nil{
                displaySetup()
            }
        }
    }
    
    
    //Silliman Courtyard (latitude: 41.31079366, longitude: -72.92481198)
    
    //@IBOutlet weak var locationLabel: UILabel! //for testing purposes
    @IBOutlet weak var clueLabel: UILabel!
    @IBOutlet weak var table: UITableView!
    @IBOutlet weak var projectTitle: UILabel!
    @IBOutlet weak var mapImageButton: UIButton!
    @IBOutlet weak var distanceLabel: UILabel!
    @IBOutlet weak var Header: UILabel!
    @IBOutlet weak var map: UIView!
    @IBOutlet weak var progressBar: UIProgressView!
    @IBOutlet weak var huntProgress: UILabel!
    @IBOutlet weak var foundIt: UIButton!
    @IBOutlet weak var nextLabel: UILabel!
    @IBOutlet weak var previousButton: UIButton!
    @IBOutlet weak var previousLabel: UILabel!

    @IBAction func mapImageTogglePressed(sender: AnyObject) {
        if mapShown==true {
            mapShown = false
            map.hidden = true
            table.hidden = false
            mapImageButton.setBackgroundImage(UIImage(named: "map_light"), forState: UIControlState.Normal)
        }else{
            mapShown = true
            map.hidden = false
            table.hidden = true
            mapImageButton.setBackgroundImage(UIImage(named: "list_light"), forState: UIControlState.Normal)
        }
        
    }

    
    override func viewDidLoad() {
        super.viewDidLoad()
        projectList = scavengerHunt.projects
        currProj = scavengerHunt.currentProject
        
        Header.text = "You are looking for"
        clueLabel.text = "Your destination is in yellow. Use the top right button to switch between the map and direction list."
        calculateDirections()
        displaySetup()
        
        //hide previous button if necessary
        if scavengerHunt.progress == 0 {
            previousButton.hidden = true
            previousLabel.hidden = true
        }
        else{
            previousButton.hidden = false
            previousLabel.hidden = false
        }
        
        //Subscribe to location update notification
        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(self.onLocUpdate(_:)), name: GlobalNotificationKeys.locationUpdate, object: nil)
    }
    
    override func viewWillAppear(animated: Bool) {
        if (scavengerHunt.transition == true && (scavengerHunt.progress + 1) < scavengerHunt.projects.count){

            scavengerHunt.progress += 1
            
            currProj = scavengerHunt.currentProject  //update currProj
                      
            if scavengerHunt.progress == 0 {
                previousButton.hidden = true
                previousLabel.hidden = true
            }
            else{
                previousButton.hidden = false
                previousLabel.hidden = false
            }
            foundIt.hidden = false
            nextLabel.hidden = false
            
            
            //set up display
            calculateDirections()
            displaySetup()
        }
            
        else if (scavengerHunt.transition == true) {
            progressBar.setProgress(1.0, animated: false)
            scavengerHunt.progress = -1
           
            MainModel.hunt = nil
            
            Header.text = "Congratulations!"
            projectTitle.text = "You've finished the hunt!"
            clueLabel.text = "Click the top left arrow to return to the Main Menu"
            distanceLabel.hidden = true
            foundIt.hidden = true
            nextLabel.hidden = true
            previousButton.hidden = true
            previousLabel.hidden = true
        }
    }
    
    @IBAction func buttonPressed(sender: AnyObject) {
        self.navigationController?.popViewControllerAnimated(true)
    }
    
    @IBAction func foundButtonPressed(sender: AnyObject) {
        currentRoute = nil
        scavengerHunt.transition = true
        viewWillAppear(false)
    }
    
    @IBAction func previousButtonPressed(sender: AnyObject) {
        currentRoute = nil
        scavengerHunt.progress = scavengerHunt.progress - 2
        scavengerHunt.transition = true
        viewWillAppear(false)
    }
    
    func onLocUpdate(notification: NSNotification){        
        //Take Action on Notification
        let userLoc = notification.object as! CLLocation
        let distance = currProj.location.distanceFromLocation(userLoc)
        self.distanceLabel.text = "Distance: " + distance.toDistanceString()
        
        if (distance < Double(currProj.radius)){
            let vc = self.storyboard!.instantiateViewControllerWithIdentifier("arrivalViewController") as! ArrivalViewController
            presentViewController(vc, animated: false, completion: nil) //transition to arrival view controller
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func calculateDirections(){
        let request: MKDirectionsRequest = MKDirectionsRequest()
        
        request.source = MKMapItem(placemark: MKPlacemark(coordinate: LocationUtil.lastLocation!.coordinate, addressDictionary: nil))
        request.destination = scavengerHunt.projects[scavengerHunt.progress].mapItem
        request.requestsAlternateRoutes = true
        request.transportType = .Walking
        
        let directions = MKDirections(request: request)
        directions.calculateDirectionsWithCompletionHandler ({(response: MKDirectionsResponse?, error: NSError?) in
            if let routeResponse = response?.routes {
                self.currentRoute =
                    routeResponse.sort({$0.expectedTravelTime <
                        $1.expectedTravelTime})[0]
                
            } else if error != nil {
                self.currentRoute = nil
            }
        })

    }
    
    func displaySetup(){
        projectTitle.text = currProj.title
        
        if currentRoute != nil{
        storyboardtwo = UIStoryboard(name: "Main", bundle: nil)
        vc = storyboardtwo.instantiateViewControllerWithIdentifier(vcIdentifiers.mapVC) as! MapViewController
        var notDestination = scavengerHunt.projects
        notDestination.removeAtIndex(scavengerHunt.progress)
        vc.displayData = [(UIColor.blueColor(), notDestination),(UIColor.yellowColor(), [scavengerHunt.projects[scavengerHunt.progress]])]
        vc.route = currentRoute
        vc.shouldDisplayUsersLocation = true
        map.addSubview(vc.view)
        self.addChildViewController(vc)
        map.layoutIfNeeded()
        vc.view.frame = map.bounds
        self.table.reloadData()
        }
        else {
            //Loading screen
        }
        table.hidden = true
        map.hidden = false
        mapShown = true
        
        //update progress bar
        progressBar.setProgress(Float(scavengerHunt.progress)/Float(scavengerHunt.projects.count), animated: false)
    }
}

extension ScavengerHuntViewController : UITableViewDelegate, UITableViewDataSource {
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        if currentRoute == nil{
            return 1
        }
        else{
            return currentRoute!.steps.count
        }
        
    }
    
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell
    {
        let cell = self.table.dequeueReusableCellWithIdentifier("instructionCell")!
        cell.userInteractionEnabled = false
        
        if currentRoute != nil{
            let steps = scavengerHunt.routes[scavengerHunt.progress].steps
            let step = steps[indexPath.row]
            let instructions = step.instructions
            let distance = step.distance
            cell.textLabel?.text = "\(indexPath.row+1). \(instructions) - \(distance) meters"
        }
        else{
            cell.textLabel?.text = "Directions Not Available"
        }
        return cell
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath: NSIndexPath) -> CGFloat {
        return 100
    }
}
