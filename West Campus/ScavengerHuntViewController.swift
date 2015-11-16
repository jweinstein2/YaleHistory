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
    let CEIDLoc = CLLocationCoordinate2D(latitude: 41.312788, longitude: -72.925319)
    let regionRadius = 30
    
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
        locationManager.desiredAccuracy = kCLLocationAccuracyBestForNavigation
        locationManager.distanceFilter = 1


        locationManager.startUpdatingLocation()
        
        NSLog(String(locationManager.activityType))
        
    }
    
    func locationManager(manager: CLLocationManager, didUpdateLocations locations: [CLLocation]){
        
        let distance = 6371000 * arccos(sin(pi/180*(90-CEIDLoc.latitude)) *sin(locations[0].coordinate.latitude)*cos(locations[0].coordinate.longitude-CEIDLoc.longitude) + cos(CEIDLoc.longitude)*cos(locations[0].coordinate.longitude))   //calculate distance from starting point using the spherical coordinate formula D = Radius * arccos(sin φ1 sin φ2 cos(θ1-θ2) + cos φ1 cos φ2)
        
        if (distance < regionRadius){
            view.backgroundColor = UIColor.greenColor()
        }
        
        else if (distance > regionRadius){
            view.backgroundColor = UIColor.redColor()
        }
        
        else{
            view.backgroundColor = UIColor.greyColor()
        }
        
        
        NSLog("update location: %f , %f", locations[0].coordinate.latitude, locations[0].coordinate.longitude)
        RegionMonitor.text = String(latitude: locations[0].coordinate.latitude, longitude:  locations[0].coordinate.longitude)
    }
    

    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
}


