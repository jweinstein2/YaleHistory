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
    
    @IBOutlet weak var RegionMonitor: UILabel!
    @IBAction func buttonPressed(sender: AnyObject) {
        self.dismissViewControllerAnimated(false, completion: nil);
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        locationManager = CLLocationManager()               //configure location manager
        locationManager.delegate = self
        locationManager.requestWhenInUseAuthorization()
        locationManager.requestAlwaysAuthorization()
        locationManager.desiredAccuracy = kCLLocationAccuracyBestForNavigation
        locationManager.distanceFilter = 1
 

        let CEIDLoc = CLLocationCoordinate2D(latitude: 41.312788, longitude: -72.925319)
        let distance = CLLocationDistance(20)
        let CEIDRegion = CLCircularRegion(center: CEIDLoc, radius: distance, identifier: "CEID1")   //create a circular region
        

        locationManager.startMonitoringForRegion(CEIDRegion)
        NSLog(CLLocationManager.isMonitoringAvailableForClass(CLCircularRegion))
        locationManager.requestStateForRegion(CEIDRegion)
        locationManager.startUpdatingLocation()
        
    }
    
    func locationManager(manager: CLLocationManager, didStartMonitoringForRegion region: CLRegion){
        NSLog("started monitoring!")
        
    }
    
    func locationManager(manager: CLLocationManager, monitoringDidFailForRegion region: CLRegion, withError error: NSError){
        NSLog("Failed to start monitoring" + error)
            
    }
    
    func locationManager(manager: CLLocationManager, didUpdateLocations locations: [CLLocation]){

        NSLog("update location: %f , %f", locations[0].coordinate.latitude, locations[0].coordinate.longitude)
        RegionMonitor.text = String(latitude: locations[0].coordinate.latitude, longitude:  locations[0].coordinate.longitude)
    }
    
    func locationManager(manager: CLLocationManager, monitoringDidFailForRegion region: CLRegion?, error: NSError){
        NSLog("Error monitoring region")
    }
    
    func locationManager(manager: CLLocationManager, didDetermineState state: CLRegionState, region: CLRegion){
        NSLog("unknown")
        switch (state) {
        case .Unknown :
            view.backgroundColor = (UIColor.grayColor())
            NSLog("unknown")
        case .Inside :
            view.backgroundColor = (UIColor.greenColor())
            NSLog("inside")
        
        case .Outside :
            view.backgroundColor = (UIColor.redColor())
            NSLog("outside")
        }
        
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
}


