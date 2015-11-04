//
//  MapViewController.swift
//  West Campus
//
//  Created by jared weinstein on 11/3/15.
//  Copyright © 2015 ENAS118. All rights reserved.
//


//TODO: THE GOOGLE MAP EVENTUALLY NEEDS TO BE ADDED TO A SEPERATE VIEW SO THAT IT DOESNT TAKE UP THE ENTIRE SCREEN (This looks like its going to create an issue possibly large enough to necessitate a switch to apple maps. From what I'm seeing online there is no way that you can get a marker to lead you to a custom view that you made. Its apple's way of fucking over its competition.)

import UIKit
import GoogleMaps

class MapViewController: UIViewController {
    @IBAction func buttonPressed(sender: AnyObject) {
        self.dismissViewControllerAnimated(false, completion: nil);
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.

        
        //google maps loading
        let camera = GMSCameraPosition.cameraWithLatitude(41.25321796,
        longitude: -72.99570143, zoom: 16)
        let mapView = GMSMapView.mapWithFrame(CGRectZero, camera: camera)
        mapView.myLocationEnabled = true
        self.view = mapView
        let marker = GMSMarker()
        marker.position = CLLocationCoordinate2DMake(41.25321796, -72.99570143)
        marker.title = "West Campus"
        marker.snippet = "Yale"
        marker.map = mapView
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
}

