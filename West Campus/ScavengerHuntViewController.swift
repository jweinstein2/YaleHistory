//
//  ScavengerHuntViewController.swift
//  West Campus
//
//  Created by jared weinstein on 11/3/15.
//  Copyright © 2015 ENAS118. All rights reserved.
//

import UIKit
import CoreLocation

class ScavengerHuntViewController: MyViewController {
    
    var locationManager: CLLocationManager!
    
    @IBOutlet weak var RegionMonitor: UILabel!
    @IBAction func buttonPressed(sender: AnyObject) {
        self.dismissViewControllerAnimated(false, completion: nil);
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        locationManager = CLLocationManager()               //configure location manager
        locationManager.delegate = locationManager.delegate
        locationManager.desiredAccuracy = kCLLocationAccuracyBestForNavigation
        locationManager.distanceFilter = 5
        locationManager.startUpdatingLocation()

        let CEIDLoc = CLLocationCoordinate2D(latitude: 41.18748012, longitude: 72.55509721)
        let distance = CLLocationDistance(10)
        let CEIDRegion = CLCircularRegion(center: CEIDLoc, radius: distance, identifier: "CEID1")   //create a circular region
        
        locationManager.startMonitoringForRegion(CEIDRegion)
        
    }
    
    func locationManager(manager: CLLocationManager!, state: CLRegionState, region: CLRegion!){
        switch (state) {
        case .Unknown :
            view.backgroundColor = (UIColor.grayColor())
            
        case .Inside :
            view.backgroundColor = (UIColor.greenColor())
        
        case .Outside :
            view.backgroundColor = (UIColor.redColor())
            
            
        }
        
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
}


