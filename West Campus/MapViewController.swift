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
        let initialLocation = CLLocationCoordinate2D(latitude: 41.253214, longitude: -72.993835)
        map.setCenterCoordinate(initialLocation, animated: true)
        let regionRadius: CLLocationDistance = 500
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
        borderPoints.append(CLLocationCoordinate2DMake(41.251848, -72.995937))//update this to be the border of our project
        borderPoints.append(CLLocationCoordinate2DMake(41.251848, -72.992204))
        borderPoints.append(CLLocationCoordinate2DMake(41.254533, -72.992204))
        borderPoints.append(CLLocationCoordinate2DMake(41.254533, -72.995937))
        let border : MKPolygon! = MKPolygon.init(coordinates: &borderPoints, count: borderPoints.count)
        border.title = "Border"
        map.addOverlay(border)
        //border

        
        var pathPoints = [CLLocationCoordinate2D]()
        //Add or remove from this list to change the displayed border
        
        pathPoints.append(CLLocationCoordinate2DMake(41.310544, -72.926282))
        pathPoints.append(CLLocationCoordinate2DMake(41.311729, -72.925563))
        pathPoints.append(CLLocationCoordinate2DMake(41.312933, -72.925271))
        pathPoints.append(CLLocationCoordinate2DMake(41.314061, -72.925506))
        pathPoints.append(CLLocationCoordinate2DMake(41.314416, -72.925892))

        var path : MKPolyline = MKPolyline.init(coordinates: &pathPoints, count: pathPoints.count)
        path.title = "path"
        map.addOverlay(path)
        //

        
        pathPoints = [CLLocationCoordinate2D]()
        /*
        pathPoints.append(CLLocationCoordinate2DMake(41.253042, -72.995909))
        pathPoints.append(CLLocationCoordinate2DMake(41.253036, -72.995667))
        pathPoints.append(CLLocationCoordinate2DMake(41.253044, -72.995385))
        pathPoints.append(CLLocationCoordinate2DMake(41.253016, -72.995225))
        pathPoints.append(CLLocationCoordinate2DMake(41.253035, -72.995118))
        pathPoints.append(CLLocationCoordinate2DMake(41.253091, -72.995021))
        path = MKPolyline.init(coordinates: &pathPoints, count: pathPoints.count)
        path.title = "path2"
        map.addOverlay(path)
*/
        pathPoints.append(CLLocationCoordinate2DMake(41.252978, -72.995873))
        pathPoints.append(CLLocationCoordinate2DMake(41.252967, -72.995601))
        pathPoints.append(CLLocationCoordinate2DMake(41.252992, -72.995307))
        pathPoints.append(CLLocationCoordinate2DMake(41.252967, -72.995164))
        pathPoints.append(CLLocationCoordinate2DMake(41.253036, -72.994982))
    
        pathPoints.append(CLLocationCoordinate2DMake(41.253036, -72.994982))
        pathPoints.append(CLLocationCoordinate2DMake(41.253096, -72.995047))
        pathPoints.append(CLLocationCoordinate2DMake(41.253260, -72.994985))
        pathPoints.append(CLLocationCoordinate2DMake(41.253422, -72.994921))
        //Tom's path 2
        
        path = MKPolyline.init(coordinates: &pathPoints, count: pathPoints.count)
        path.title = "path2"
        map.addOverlay(path)
        
        pathPoints = [CLLocationCoordinate2D]()
        //pathPoints.append(CLLocationCoordinate2DMake(41.252988, -72.994438))
        //pathPoints.append(CLLocationCoordinate2DMake(41.253035, -72.994874))
        //pathPoints.append(CLLocationCoordinate2DMake(41.253044, -72.995385))
        //pathPoints.append(CLLocationCoordinate2DMake(41.253044, -72.994581))
        //pathPoints.append(CLLocationCoordinate2DMake(41.253036, -72.994495))
        //pathPoints.append(CLLocationCoordinate2DMake(41.253040, -72.994715))
        //pathPoints.append(CLLocationCoordinate2DMake(41.253033, -72.995001))
        //pathPoints.append(CLLocationCoordinate2DMake(41.253035, -72.994874))
        
        //pathPoints.append(CLLocationCoordinate2DMake(41.253044, -72.994581))
        
        pathPoints.append(CLLocationCoordinate2DMake(41.253422, -72.994921))
        
        pathPoints.append(CLLocationCoordinate2DMake(41.253426, -72.995015))
        pathPoints.append(CLLocationCoordinate2DMake(41.253450, -72.995114))
        pathPoints.append(CLLocationCoordinate2DMake(41.253456, -72.995309))
        pathPoints.append(CLLocationCoordinate2DMake(41.253456, -72.995431))
        pathPoints.append(CLLocationCoordinate2DMake(41.253458, -72.995468))
        
        pathPoints.append(CLLocationCoordinate2DMake(41.253469, -72.995501))
        pathPoints.append(CLLocationCoordinate2DMake(41.253505, -72.995549))
        //Tom path 3
        
        pathPoints.append(CLLocationCoordinate2DMake(41.252855, -72.994380))
        pathPoints.append(CLLocationCoordinate2DMake(41.252872, -72.994372))
        pathPoints.append(CLLocationCoordinate2DMake(41.252850, -72.994254))
        pathPoints.append(CLLocationCoordinate2DMake(41.252851, -72.994036))
        pathPoints.append(CLLocationCoordinate2DMake(41.252825, -72.993949))
        pathPoints.append(CLLocationCoordinate2DMake(41.252793, -72.993897))
        
        pathPoints.append(CLLocationCoordinate2DMake(41.252339, -72.993493))
        pathPoints.append(CLLocationCoordinate2DMake(41.252307, -72.993447))
        pathPoints.append(CLLocationCoordinate2DMake(41.252286, -72.993355))
        pathPoints.append(CLLocationCoordinate2DMake(41.252379, -72.993352))
        pathPoints.append(CLLocationCoordinate2DMake(41.252486, -72.993316))
        pathPoints.append(CLLocationCoordinate2DMake(41.252568, -72.993329))
        pathPoints.append(CLLocationCoordinate2DMake(41.252606, -72.993336))
        pathPoints.append(CLLocationCoordinate2DMake(41.252714, -72.993436))
        
        pathPoints.append(CLLocationCoordinate2DMake(41.252814, -72.993494))
        pathPoints.append(CLLocationCoordinate2DMake(41.252881, -72.993584))
        pathPoints.append(CLLocationCoordinate2DMake(41.252928, -72.993645))
        pathPoints.append(CLLocationCoordinate2DMake(41.253028, -72.993565))
        pathPoints.append(CLLocationCoordinate2DMake(41.253110, -72.993536))
        path = MKPolyline.init(coordinates: &pathPoints, count: pathPoints.count)
        path.title = "path3"
        map.addOverlay(path)
        
        pathPoints.append(CLLocationCoordinate2DMake(41.253110, -72.993536))
        pathPoints.append(CLLocationCoordinate2DMake(41.253107, -72.993633))
        pathPoints.append(CLLocationCoordinate2DMake(41.253232, -72.993673))
        pathPoints.append(CLLocationCoordinate2DMake(41.253290, -72.993743))
        pathPoints.append(CLLocationCoordinate2DMake(41.253275, -72.993866))
        
        pathPoints.append(CLLocationCoordinate2DMake(41.253252, -72.993961))
        pathPoints.append(CLLocationCoordinate2DMake(41.253182, -72.994092))
        pathPoints.append(CLLocationCoordinate2DMake(41.253231, -72.994159))
        pathPoints.append(CLLocationCoordinate2DMake(41.253204, -72.994464))
        pathPoints.append(CLLocationCoordinate2DMake(41.253186, -72.994514))
        
        pathPoints.append(CLLocationCoordinate2DMake(41.253178, -72.994550))
        pathPoints.append(CLLocationCoordinate2DMake(41.253199, -72.994626))
        pathPoints.append(CLLocationCoordinate2DMake(41.253145, -72.994955))
        
        path = MKPolyline.init(coordinates: &pathPoints, count: pathPoints.count)
        path.title = "path4"
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
