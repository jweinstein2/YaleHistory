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
    let regionRadius : Double! = 10.0
    
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
        
        let destLat = (CEIDLoc.latitude)
        let destLong = CEIDLoc.longitude
        
        let curLat = (locations[0].coordinate.latitude)
        let curLong = locations[0].coordinate.longitude
        
        let x = 111111*(curLat-destLat)
        
        let y = 111111*(curLong-destLong)
        
        let distance :Double = sqrt(x*x+y*y)
        
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

    



