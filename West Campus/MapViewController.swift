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

class MapViewController: UIViewController, MKMapViewDelegate {
    @IBOutlet weak var map: MKMapView!
    var projectsToBeDisplayed = [Project]() //This is the array containing a list of all the projects we want to display pins for. Use projectsToBeDisplayed[i].gpslatitude / longitude
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpMap()
    }
    
    func setUpMap(){
        map.mapType = MKMapType.Satellite
        map.zoomEnabled = true
        map.scrollEnabled = true
        map.delegate = self
        map.showsUserLocation = true
        let initialLocation = CLLocationCoordinate2D(latitude: 41.253276, longitude: -72.995744)
        map.setCenterCoordinate(initialLocation, animated: true)
        let regionRadius: CLLocationDistance = 1000
        func centerMapOnLocation(location: CLLocationCoordinate2D) {
            let coordinateRegion = MKCoordinateRegionMakeWithDistance(location, regionRadius * 2.0, regionRadius * 2.0)
        map.setRegion(coordinateRegion, animated: true)
        }
        centerMapOnLocation(initialLocation)
        addOverlay()
    }
    
    func addOverlay(){
        var borderPoints = [CLLocationCoordinate2D]()
        //Add or remove from this list to change the displayed border
        borderPoints.append(CLLocationCoordinate2DMake(41.243276, -73.005744))//update this to be the border of our project
        borderPoints.append(CLLocationCoordinate2DMake(41.243276, -72.985744))
        borderPoints.append(CLLocationCoordinate2DMake(41.263276, -72.985744))
        borderPoints.append(CLLocationCoordinate2DMake(41.263276, -73.005744))
        let border : MKPolygon! = MKPolygon.init(coordinates: &borderPoints, count: borderPoints.count)
        border.title = "Border"
        map.addOverlay(border)
        
        
        var pathPoints = [CLLocationCoordinate2D]()
        //Add or remove from this list to change the displayed border
        pathPoints.append(CLLocationCoordinate2DMake(41.254276, -72.996744))
        pathPoints.append(CLLocationCoordinate2DMake(41.254276, -72.994744))
        pathPoints.append(CLLocationCoordinate2DMake(41.252276, -72.994744))
        pathPoints.append(CLLocationCoordinate2DMake(41.252276, -72.996744))
        let path : MKPolyline = MKPolyline.init(coordinates: &pathPoints, count: pathPoints.count)
        path.title = "path"
        map.addOverlay(path)
        //iterate through the projectsToBeDisplayed array list, [i].longitude, latitude
       for var i = 0; i < projectsToBeDisplayed.count; i++ {
        var lat = projectsToBeDisplayed[i].gpsLatitude
        var long = projectsToBeDisplayed[i].gpsLongitude
        //var MKAnnotation
    }
    }
    
    func mapView(mapView: MKMapView, rendererForOverlay overlay: MKOverlay) -> MKOverlayRenderer {
        if overlay is MKPolygon {
            //These are the settings for our outer border
            let polygonRender = MKPolygonRenderer(overlay: overlay)
            polygonRender.strokeColor = UIColor.whiteColor()
            polygonRender.lineWidth = 1
            polygonRender.fillColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.2)
            return polygonRender
        }else if overlay is MKPolyline{
            //These are the settings for our path lines
            let polylineRender = MKPolylineRenderer(overlay: overlay)
            polylineRender.strokeColor = UIColor.blueColor()
            polylineRender.lineWidth = 2
            polylineRender.fillColor = UIColor(red: 0, green: 0, blue: 0, alpha: 1)
            return polylineRender
        }
        NSLog("Error: mapView in mapViewController got passed an overlay that wasn't properly handled")
        let polygonRender = MKPolygonRenderer(overlay: overlay)
        return polygonRender
    }
}
