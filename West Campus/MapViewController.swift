//
//  mapView.swift
//  West Campus
//
//  Created by jared weinstein on 11/13/15.
//  Copyright © 2015 ENAS118. All rights reserved.
//
import Foundation
import UIKit
import MapKit

class MapViewController: UIViewController {
    @IBOutlet weak var map: MKMapView!
    var projectsToBeDisplayed = [Project]() //This is the array containing a list of all the projects we want to display pins for. Use projectsToBeDisplayed[i].gpslatitude / longitude
    
    override func viewDidLoad() {
        super.viewDidLoad()
        map.mapType = MKMapType.Satellite
        //map.zoomEnabled = false
        map.scrollEnabled = false
        let initialLocation = CLLocationCoordinate2D(latitude: 41.3125884, longitude: -72.9249614)
        map.setCenterCoordinate(initialLocation, animated: true)
        
        let regionRadius: CLLocationDistance = 1000
        func centerMapOnLocation(location: CLLocationCoordinate2D) {
            let coordinateRegion = MKCoordinateRegionMakeWithDistance(location,
                regionRadius * 2.0, regionRadius * 2.0)
            map.setRegion(coordinateRegion, animated: true)
        }

        //This needs to be configured so that the rectangle covers the appropriate part of the map
        //map.setVisibleMapRect(mapRect: MKMapRectanimated true)
        centerMapOnLocation(initialLocation)
    }
    
    /*override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }*/
}
