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
    
    var displayData = [(color: UIColor, projects: [Project])]()
    var shouldDisplayUsersLocation = false

    private let reuseId = "com.yalehistory.mappin"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setUpMap()
    }
    
    func setUpMap(){
        self.addOverlay()
        
        map.mapType = MKMapType.Hybrid

        map.zoomEnabled = true
        map.scrollEnabled = true
        map.showsUserLocation = shouldDisplayUsersLocation
        let initialLocation = CLLocationCoordinate2D(latitude: 41.251938,longitude: -72.994110)
        map.setCenterCoordinate(initialLocation, animated: true)
        let regionRadius: CLLocationDistance = 1000
        func centerMapOnLocation(location: CLLocationCoordinate2D) {
            let coordinateRegion = MKCoordinateRegionMakeWithDistance(location, regionRadius * 2.0, regionRadius * 2.0)
        map.setRegion(coordinateRegion, animated: true)
        }
        centerMapOnLocation(initialLocation)
    }
    
    func addOverlay(){
        //iterate through the projectsToBeDisplayed array list, [i].longitude, latitude
        for projectList in displayData {
            for project in projectList.projects {
                let lat = project.location.coordinate.latitude
                let long = project.location.coordinate.longitude
                let loc : CLLocationCoordinate2D = CLLocationCoordinate2D(latitude: lat, longitude: long)
                let annotation = MapPointAnnotation.init()
                annotation.coordinate = loc
                annotation.color = projectList.color
                annotation.title = project.title
                annotation.project = project
                self.map.addAnnotation(annotation)
            }
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
            
            polylineRender.strokeColor = UIColor(red:0.00, green: 0.40, blue: 0.00, alpha: 1.0)
            polylineRender.lineWidth = 2
            polylineRender.fillColor = UIColor(red: 0, green: 0, blue: 0, alpha: 1)
            return polylineRender
        }
        NSLog("Error: mapView in mapViewController got passed an overlay that wasn't properly handled")
        let polygonRender = MKPolygonRenderer(overlay: overlay)
        return polygonRender
    }
    
    func mapView(mapView: MKMapView, viewForAnnotation annotation: MKAnnotation) -> MKAnnotationView? {
        if annotation is MKUserLocation {
            //return nil so map view draws "blue dot" for standard user location
            return nil
        } else if annotation is MapPointAnnotation {
            let color = (annotation as! MapPointAnnotation).color
            //let highlighted = mapPointAnnotation.project === highlightedProject
            var pinView = map.dequeueReusableAnnotationViewWithIdentifier(self.reuseId) as? MKPinAnnotationView
            if pinView == nil {
                //if highLightedProjects?.contains(pinView.pr)
                pinView = MKPinAnnotationView(annotation: annotation, reuseIdentifier: self.reuseId)
                pinView!.pinTintColor = color
                pinView!.canShowCallout = true
                pinView!.rightCalloutAccessoryView = UIButton.init(type: .DetailDisclosure)
            }
            return pinView
        }
        return nil
    }
    
    func mapView(mapView: MKMapView, annotationView view: MKAnnotationView, calloutAccessoryControlTapped control: UIControl) {
        if view.annotation is MapPointAnnotation {
            let mapAnnotation = view.annotation as! MapPointAnnotation
            let project = mapAnnotation.project
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            let vc = storyboard.instantiateViewControllerWithIdentifier("projectViewController") as! ProjectViewController
            vc.project = project
            self.navigationController?.pushViewController(vc, animated: true)
        }
    }
}
