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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        map.mapType = MKMapType.Satellite
        map.zoomEnabled = false
        map.scrollEnabled = false
        map.setCenterCoordinate(CLLocationCoordinate2D(latitude: 41.3125884, longitude: -72.9249614), animated: true)
        //This needs to be configured so that the rectangle covers the appropriate part of the map
        //map.setVisibleMapRect(mapRect: MKMapRectanimated true)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}
