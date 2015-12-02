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
        //map.delegate = self //The pins are added even if this line is commented out
        setUpMap()
    }
    
    func setUpMap(){
        map.mapType = MKMapType.Satellite
        map.zoomEnabled = true
        map.scrollEnabled = true
        map.showsUserLocation = true
        let initialLocation = CLLocationCoordinate2D(latitude: 41.310833, longitude: -72.926114)
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
            let lat = projectsToBeDisplayed[i].gpsLatitude
            let long = projectsToBeDisplayed[i].gpsLongitude
            let loc : CLLocationCoordinate2D = CLLocationCoordinate2D(latitude: lat, longitude: long)
            let annotation = MKPointAnnotation.init()
            annotation.coordinate = loc
            annotation.title = projectsToBeDisplayed[i].title
            //annotation.subtitle = "subtitle"
            map.addAnnotation(annotation)
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
    
    //MKAnnotation Customization ------NONE OF THIS IS GETTING CALLED ---------------
    //This needs to get called when every annotation is rendered but it isn't for some reason
    func mapView(mapView: MKMapView, viewForAnnotation annotation: MKAnnotation) -> MKAnnotationView? {
        NSLog("CALLED VIEWFORANNOTATION")
        if annotation is MKUserLocation {
            //return nil so map view draws "blue dot" for standard user location
            return nil
        }
        
        let reuseId = "myPin"
        let pinView = map.dequeueReusableAnnotationViewWithIdentifier(reuseId) as? MKPinAnnotationView
        if pinView == nil {
            NSLog("annotation set up")
            let pinAnnotationView = MKPinAnnotationView(annotation: annotation, reuseIdentifier: "myPin")
            pinAnnotationView.pinTintColor = UIColor.purpleColor()
            pinAnnotationView.canShowCallout = true
            let moreButton = UIButton.init(type: UIButtonType.Custom) as UIButton
            moreButton.frame.size.width = 44
            moreButton.frame.size.height = 44
            moreButton.backgroundColor = UIColor.purpleColor()
            moreButton.setImage(UIImage(named: "home"), forState: .Normal)
            pinAnnotationView.rightCalloutAccessoryView = moreButton
            return pinAnnotationView
        }
        return nil
    }
    
    //None of these are getting called. Possible issue where the delegate is not set correctly.
    func mapView(mapView: MKMapView, didAddAnnotationViews views: [MKAnnotationView]) {
        NSLog("hello")
    }
    
    func mapView(mapView: MKMapView, didSelectAnnotationView view: MKAnnotationView) {
        NSLog("HELLO")
    }
    
    func mapView(mapView: MKMapView, annotationView view: MKAnnotationView, calloutAccessoryControlTapped control: UIControl) {
            NSLog("COOL")
    }
}
