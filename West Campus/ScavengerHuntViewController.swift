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
    @IBOutlet weak var distanceLabel: UILabel!
    
    var locationManager: CLLocationManager!
    let CEIDLoc = CLLocationCoordinate2D(latitude: 41.312788, longitude: -72.925319)
    let regionRadius : Double! = 30.0
    
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
        
        let destLat = (M_PI/180)*(90-CEIDLoc.latitude)
        let destLong = (M_PI/180)*CEIDLoc.longitude
        
        let curLat = (M_PI/180)*(90-locations[0].coordinate.latitude)
        let curLong = (M_PI/180)*locations[0].coordinate.longitude
        
        let distance = 6371000 * acos(sin(destLat) * sin(curLat)*cos(curLong-destLong) + cos(destLong)*cos(curLong))   //calculate distance from starting point using the spherical coordinate formula D = Radius * arccos(sin φ1 sin φ2 cos(θ1-θ2) + cos φ1 cos φ2)
        distanceLabel.text = String(distance)
        
        if (distance < regionRadius){
            view.backgroundColor = UIColor.greenColor()
        }
        
        else if (distance > regionRadius){
            view.backgroundColor = UIColor.redColor()
        }
        
        else{
            view.backgroundColor = UIColor.grayColor()
        }
        
        
        NSLog("update location: %f , %f", locations[0].coordinate.latitude, locations[0].coordinate.longitude)
        RegionMonitor.text = String(latitude: locations[0].coordinate.latitude, longitude:  locations[0].coordinate.longitude)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

    



