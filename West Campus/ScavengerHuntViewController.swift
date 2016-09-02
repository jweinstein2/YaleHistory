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
    var vc : MapViewController!
    var mapShown = false
    var currProj: Project!
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
    @IBOutlet weak var table: UITableView!
    @IBOutlet weak var projectTitle: UILabel!
    @IBOutlet weak var distanceLabel: UILabel!
    @IBOutlet weak var Header: UILabel!
    @IBOutlet weak var map: UIView!
    @IBOutlet weak var progressBar: UIProgressView!
    @IBOutlet weak var huntProgress: UILabel!
    @IBOutlet weak var mapDirectionToggle: UISegmentedControl!
    @IBOutlet weak var foundIt: UIButton!
    @IBOutlet weak var nextLabel: UILabel!
    @IBOutlet weak var previousButton: UIButton!
    @IBOutlet weak var previousLabel: UILabel!
    @IBOutlet weak var backHeader: HeaderView!

    @IBAction func segmentedValueChanged(sender: UISegmentedControl) {
        switch sender.selectedSegmentIndex {
        case 0:
            //Show the map
            mapShown = true
            map.hidden = false
            table.hidden = true
        case 1:
            //Show the list
            mapShown = false
            map.hidden = true
            table.hidden = false
        default:
            NSLog("Error: Segmented control not handled properly")
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        projectList = scavengerHunt.projects
        currProj = scavengerHunt.currentProject
        Header.text = "You are walking to"
        
        calculateDirections()
        displaySetup()
        
        //show map, hide directions
        table.hidden = true
        map.hidden = false
        mapShown = true
        
        //hide previous button if necessary
        if scavengerHunt.progress == 0 {
            previousButton.userInteractionEnabled = false
            previousLabel.alpha = 0.4
            previousButton.alpha = 0.4
        }
        else{
            previousButton.userInteractionEnabled = true
            previousLabel.alpha = 1
            previousButton.alpha = 1
        }
        
        //Subscribe to location update notification
        /*NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(self.onLocUpdate(_:)), name: GlobalNotificationKeys.locationUpdate, object: nil)*/
    }
    
    override func viewWillAppear(animated: Bool) {
        
        //subscribe to location update notification
        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(self.onLocUpdate(_:)), name: GlobalNotificationKeys.locationUpdate, object: nil)
        
        if (scavengerHunt.transition == true && (scavengerHunt.progress + 1) < scavengerHunt.projects.count){

            scavengerHunt.progress += 1
            
            currProj = scavengerHunt.currentProject  //update currProj
                      
            if scavengerHunt.progress == 0 {
                previousButton.userInteractionEnabled = false
                previousLabel.alpha = 0.4
                previousButton.alpha = 0.4
            }
            else{
                previousButton.userInteractionEnabled = true
                previousLabel.alpha = 1
                previousButton.alpha = 1
            }
            foundIt.hidden = false
            nextLabel.hidden = false
            scavengerHunt.transition = false
            
            //set up display
            calculateDirections()
            displaySetup()
        }
            
        else if (scavengerHunt.transition == true) {
            let vc = self.storyboard!.instantiateViewControllerWithIdentifier("sHFinishViewController")
            var vcs = self.navigationController?.viewControllers
            vcs?.removeLast()
            vcs?.append(vc)
            self.navigationController?.viewControllers = vcs!
            scavengerHunt.transition = false
        }
    }
    
    @IBAction func foundButtonPressed(sender: AnyObject) {
        currentRoute = nil
        scavengerHunt.transition = true
        viewWillAppear(false)
    }
    
    @IBAction func previousButtonPressed(sender: AnyObject) {
        if scavengerHunt.progress == -1{
            foundIt.userInteractionEnabled = true
            nextLabel.alpha = 1
            foundIt.alpha = 1
        
            scavengerHunt.progress = scavengerHunt.projects.count
            
            Header.text = "You are walking to"
            distanceLabel.text = "Distance: ~"
        }
        
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
            self.navigationController?.pushViewController(vc, animated: true)
            NSNotificationCenter.defaultCenter().removeObserver(self, name: GlobalNotificationKeys.locationUpdate, object: nil)
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
        

        let sb = UIStoryboard(name: "Main", bundle: nil)
        vc = sb.instantiateViewControllerWithIdentifier(vcIdentifiers.mapVC) as! MapViewController
        var notDestination = scavengerHunt.projects
        notDestination.removeAtIndex(scavengerHunt.progress)
        vc.displayData = [(ThemeColors.lightMapBlue, notDestination),(UIColor.yellowColor(), [scavengerHunt.projects[scavengerHunt.progress]])]
        if currentRoute != nil {
            vc.route = currentRoute
        }
        else {
            vc.route = nil
        }
        vc.shouldDisplayUsersLocation = true
        map.addSubview(vc.view)
        self.addChildViewController(vc)
        map.layoutIfNeeded()
        vc.view.frame = map.bounds
        self.table.reloadData()
        
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
            let steps = currentRoute!.steps
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
