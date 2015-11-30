//
//  ScavengerHuntViewController.swift
//  West Campus
//
//  Created by jared weinstein on 11/3/15.
//  Copyright © 2015 ENAS118. All rights reserved.
//

import UIKit
import CoreLocation

class ScavengerHuntViewController: MyViewController, CLLocationManagerDelegate {

    var locationManager: CLLocationManager!
    var currProj: Project!
    let CEIDLoc = CLLocationCoordinate2D(latitude: 41.31169929, longitude: -72.9284069)
    let regionRadius : Double! = 15.0
    
    //Silliman Courtyard (latitude: 41.31079366, longitude: -72.92481198)
    
    @IBOutlet weak var clueLabel: UILabel!
    @IBOutlet weak var projectTitle: UILabel!
    @IBOutlet weak var distanceLabel: UILabel!
    @IBOutlet weak var Header: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        locationManager = CLLocationManager()               //configure location manager
        locationManager.delegate = self
        locationManager.requestWhenInUseAuthorization()
        locationManager.desiredAccuracy = kCLLocationAccuracyBestForNavigation
        locationManager.distanceFilter = 1


        locationManager.startUpdatingLocation()
        
        NSLog(String(locationManager.activityType))
        
        Header.text = "You are looking for"
        
        MyViewController.model.currentProject = 0
        currProj = MyViewController.model.projects.projectData[MyViewController.model.currentProject]
        projectTitle.text = currProj.title
        
    }
    
    @IBAction func huntButtonPressed(sender: AnyObject){
        
        if ((MyViewController.model.currentProject + 1) < MyViewController.model.projects.projectData.count){
            MyViewController.model.currentProject = MyViewController.model.currentProject + 1 //go to next project
            currProj = MyViewController.model.projects.projectData[MyViewController.model.currentProject]   //update currProj
   
        
        clueLabel.hidden = false
        distanceLabel.hidden = false
        projectTitle.text = currProj.title
        Header.text = "You are looking for"
        
        view.backgroundColor = UIColor.blueColor()
        
        
        }
        
        else  {     //code for finishing the Hunt
            locationManager.stopUpdatingLocation()
            Header.hidden = true
            projectTitle.hidden = true
        }
    }
    
    @IBAction func buttonPressed(sender: AnyObject) {
        
        self.dismissViewControllerAnimated(false, completion: nil);
        
    }
    
    func locationManager(manager: CLLocationManager, didUpdateLocations locations: [CLLocation]){
        
        NSLog("%f", currProj.gpsLatitude)
        
        let destLat = currProj.gpsLatitude // CEIDLoc.latitude
        let destLong = currProj.gpsLongitude // CEIDLoc.longitude
        
        let curLat = locations[0].coordinate.latitude
        let curLong = locations[0].coordinate.longitude
        
        let x = 111111*(curLat-destLat)
        
        let y = 111111*(curLong-destLong)
        
        let distance :Double = sqrt(x*x+y*y)
        
        clueLabel.text = currProj.clue
        distanceLabel.text = NSString(format: "Distance from project: %.2f", distance) as String
        
        if (distance < regionRadius){
            view.backgroundColor = UIColor.greenColor()
            
            Header.text = "Congratulations, you have reached"
            
            clueLabel.hidden = true
            distanceLabel.hidden = true
        }
        
        
        NSLog("update location: %f , %f", locations[0].coordinate.latitude, locations[0].coordinate.longitude)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

    



