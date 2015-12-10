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
        map.delegate = self
        setUpMap()
    }
    
    func setUpMap(){
        map.mapType = MKMapType.Satellite

        map.zoomEnabled = true
        map.scrollEnabled = true
        map.showsUserLocation = true
        let initialLocation = CLLocationCoordinate2D(latitude: 41.251938,longitude: -72.994110)
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
        borderPoints.append(CLLocationCoordinate2DMake(41.253511, -72.995858))//update this to be the border of our project
        borderPoints.append(CLLocationCoordinate2DMake(41.253973, -72.995858))
        borderPoints.append(CLLocationCoordinate2DMake(41.254014, -72.995654))
        borderPoints.append(CLLocationCoordinate2DMake(41.254136, -72.995460))
        borderPoints.append(CLLocationCoordinate2DMake(41.254337, -72.995460))
        borderPoints.append(CLLocationCoordinate2DMake(41.254410, -72.995298))
        borderPoints.append(CLLocationCoordinate2DMake(41.254469, -72.995104))
        borderPoints.append(CLLocationCoordinate2DMake(41.254396, -72.994856))
        borderPoints.append(CLLocationCoordinate2DMake(41.254291, -72.994640))
        //borderPoints.append(CLLocationCoordinate2DMake(41.254154, -72.994478))
        //borderPoints.append(CLLocationCoordinate2DMake(41.254089, -72.994208))
        borderPoints.append(CLLocationCoordinate2DMake(41.254462, -72.992643))
        borderPoints.append(CLLocationCoordinate2DMake(41.255055, -72.992016))
        borderPoints.append(CLLocationCoordinate2DMake(41.255430, -72.991248))
        borderPoints.append(CLLocationCoordinate2DMake(41.255515, -72.990804))
        borderPoints.append(CLLocationCoordinate2DMake(41.255186, -72.990421))
        borderPoints.append(CLLocationCoordinate2DMake(41.254727, -72.991137))
        borderPoints.append(CLLocationCoordinate2DMake(41.254631, -72.991370))
        borderPoints.append(CLLocationCoordinate2DMake(41.254331, -72.991190))
        borderPoints.append(CLLocationCoordinate2DMake(41.253541, -72.992092))
        borderPoints.append(CLLocationCoordinate2DMake(41.253250, -72.991971))
        borderPoints.append(CLLocationCoordinate2DMake(41.253395, -72.991580))
        borderPoints.append(CLLocationCoordinate2DMake(41.253223, -72.991079))
        borderPoints.append(CLLocationCoordinate2DMake(41.253059, -72.990815))
        borderPoints.append(CLLocationCoordinate2DMake(41.252768, -72.990738))
        borderPoints.append(CLLocationCoordinate2DMake(41.250098, -72.994147))
        borderPoints.append(CLLocationCoordinate2DMake(41.250819, -72.995286))
        borderPoints.append(CLLocationCoordinate2DMake(41.250259, -72.996424))
        borderPoints.append(CLLocationCoordinate2DMake(41.250713, -72.998038))
        borderPoints.append(CLLocationCoordinate2DMake(41.251562, -72.998182))
        borderPoints.append(CLLocationCoordinate2DMake(41.251472, -72.995602))
        borderPoints.append(CLLocationCoordinate2DMake(41.252980, -72.995525))
        borderPoints.append(CLLocationCoordinate2DMake(41.253511, -72.995858))
       
       
        let border : MKPolygon! = MKPolygon.init(coordinates: &borderPoints, count: borderPoints.count)
        border.title = "Border"
        map.addOverlay(border)
        //border

        
        var pathPoints = [CLLocationCoordinate2D]()
        //Add or remove from this list to change the displayed border
        
        pathPoints.append(CLLocationCoordinate2DMake(41.253459, -72.995824))//bright green
        pathPoints.append(CLLocationCoordinate2DMake(41.253471, -72.995650))
        pathPoints.append(CLLocationCoordinate2DMake(41.253447, -72.995554))
        pathPoints.append(CLLocationCoordinate2DMake(41.253416, -72.995455))
        pathPoints.append(CLLocationCoordinate2DMake(41.253376, -72.995144))
        pathPoints.append(CLLocationCoordinate2DMake(41.253331, -72.994992))
        pathPoints.append(CLLocationCoordinate2DMake(41.253241, -72.994955))
        pathPoints.append(CLLocationCoordinate2DMake(41.253073, -72.994990))
        pathPoints.append(CLLocationCoordinate2DMake(41.253015, -72.995011))
        pathPoints.append(CLLocationCoordinate2DMake(41.252991, -72.995167))
        pathPoints.append(CLLocationCoordinate2DMake(41.253007, -72.995323))
        pathPoints.append(CLLocationCoordinate2DMake(41.253000, -72.995851))
        pathPoints.append(CLLocationCoordinate2DMake(41.253459, -72.995824))
     
        var path : MKPolyline = MKPolyline.init(coordinates: &pathPoints, count: pathPoints.count)
        path.title = "path"
        map.addOverlay(path)

        //Add or remove from this list to change the displayed paths
        pathPoints = [CLLocationCoordinate2D]()

        pathPoints.append(CLLocationCoordinate2DMake(41.253331, -72.994992))
        pathPoints.append(CLLocationCoordinate2DMake(41.253352, -72.994870))
        pathPoints.append(CLLocationCoordinate2DMake(41.253367, -72.994742))
        pathPoints.append(CLLocationCoordinate2DMake(41.253462, -72.994660))
        pathPoints.append(CLLocationCoordinate2DMake(41.253494, -72.994494))
        pathPoints.append(CLLocationCoordinate2DMake(41.253559, -72.994359))
        pathPoints.append(CLLocationCoordinate2DMake(41.253551, -72.994126))
        pathPoints.append(CLLocationCoordinate2DMake(41.253622, -72.993871))
        pathPoints.append(CLLocationCoordinate2DMake(41.253682, -72.993723))
        pathPoints.append(CLLocationCoordinate2DMake(41.253651, -72.993647))
        pathPoints.append(CLLocationCoordinate2DMake(41.253546, -72.993609))
        pathPoints.append(CLLocationCoordinate2DMake(41.253469, -72.993514))
        pathPoints.append(CLLocationCoordinate2DMake(41.253384, -72.993456))
        pathPoints.append(CLLocationCoordinate2DMake(41.253226, -72.993479))
        
        pathPoints.append(CLLocationCoordinate2DMake(41.252928, -72.993645))
        pathPoints.append(CLLocationCoordinate2DMake(41.252881, -72.993584))
        pathPoints.append(CLLocationCoordinate2DMake(41.252814, -72.993494))
        pathPoints.append(CLLocationCoordinate2DMake(41.252714, -72.993436))
        pathPoints.append(CLLocationCoordinate2DMake(41.252606, -72.993336))
        pathPoints.append(CLLocationCoordinate2DMake(41.252568, -72.993329))
        pathPoints.append(CLLocationCoordinate2DMake(41.252486, -72.993316))
        pathPoints.append(CLLocationCoordinate2DMake(41.252379, -72.993352))
        pathPoints.append(CLLocationCoordinate2DMake(41.252286, -72.993355))
        pathPoints.append(CLLocationCoordinate2DMake(41.252307, -72.993447))
        pathPoints.append(CLLocationCoordinate2DMake(41.252339, -72.993493))
        pathPoints.append(CLLocationCoordinate2DMake(41.252793, -72.993897))
        pathPoints.append(CLLocationCoordinate2DMake(41.252825, -72.993949))
        pathPoints.append(CLLocationCoordinate2DMake(41.252851, -72.994036))
        pathPoints.append(CLLocationCoordinate2DMake(41.252850, -72.994254))
        //pathPoints.append(CLLocationCoordinate2DMake(41.252872, -72.994372))
        //pathPoints.append(CLLocationCoordinate2DMake(41.252855, -72.994380))
        pathPoints.append(CLLocationCoordinate2DMake(41.252840, -72.994353))
        pathPoints.append(CLLocationCoordinate2DMake(41.253009, -72.994532))
        pathPoints.append(CLLocationCoordinate2DMake(41.253015, -72.995011))
        
        path = MKPolyline.init(coordinates: &pathPoints, count: pathPoints.count)
        path.title = "path2"
        map.addOverlay(path)
        
        //-----------------------------------------------------------------
        
        pathPoints = [CLLocationCoordinate2D]()
        
        pathPoints.append(CLLocationCoordinate2DMake(41.253471, -72.995650))
        pathPoints.append(CLLocationCoordinate2DMake(41.253585, -72.995683))
        pathPoints.append(CLLocationCoordinate2DMake(41.253813, -72.995596))
        pathPoints.append(CLLocationCoordinate2DMake(41.253941, -72.995306))
        pathPoints.append(CLLocationCoordinate2DMake(41.253965, -72.995176))
        pathPoints.append(CLLocationCoordinate2DMake(41.254030, -72.995127))
        pathPoints.append(CLLocationCoordinate2DMake(41.254031, -72.995136))
        pathPoints.append(CLLocationCoordinate2DMake(41.254106, -72.995103))
        pathPoints.append(CLLocationCoordinate2DMake(41.254134, -72.995033))
        pathPoints.append(CLLocationCoordinate2DMake(41.254118, -72.994998))
        pathPoints.append(CLLocationCoordinate2DMake(41.254158, -72.994853))
        pathPoints.append(CLLocationCoordinate2DMake(41.254180, -72.994709))
        pathPoints.append(CLLocationCoordinate2DMake(41.254189, -72.994525))
        pathPoints.append(CLLocationCoordinate2DMake(41.254223, -72.994377))
        
        path = MKPolyline.init(coordinates: &pathPoints, count: pathPoints.count)
        path.title = "path3"
        map.addOverlay(path)
        
        //-----------------------------------------------------------------
        pathPoints = [CLLocationCoordinate2D]()
        
        pathPoints.append(CLLocationCoordinate2DMake(41.253110, -72.993536))
        pathPoints.append(CLLocationCoordinate2DMake(41.253107, -72.993633))
        pathPoints.append(CLLocationCoordinate2DMake(41.253232, -72.993673))
        pathPoints.append(CLLocationCoordinate2DMake(41.253290, -72.993743))
        pathPoints.append(CLLocationCoordinate2DMake(41.253275, -72.993866))
        pathPoints.append(CLLocationCoordinate2DMake(41.253252, -72.993961))
        pathPoints.append(CLLocationCoordinate2DMake(41.253182, -72.994092))
        pathPoints.append(CLLocationCoordinate2DMake(41.253231, -72.994159))
        pathPoints.append(CLLocationCoordinate2DMake(41.253205, -72.994332))
        pathPoints.append(CLLocationCoordinate2DMake(41.253225, -72.994464))
        pathPoints.append(CLLocationCoordinate2DMake(41.253186, -72.994514))
        pathPoints.append(CLLocationCoordinate2DMake(41.253178, -72.994550))
        pathPoints.append(CLLocationCoordinate2DMake(41.253199, -72.994626))
        pathPoints.append(CLLocationCoordinate2DMake(41.253145, -72.994955))
        
        path = MKPolyline.init(coordinates: &pathPoints, count: pathPoints.count)
        path.title = "path4"
        map.addOverlay(path)
        
        pathPoints = [CLLocationCoordinate2D]()
        //-----------------------------------------------------------------
        pathPoints = [CLLocationCoordinate2D]()
        
        pathPoints.append(CLLocationCoordinate2DMake(41.253965, -72.995176))
        pathPoints.append(CLLocationCoordinate2DMake(41.253962, -72.995084))
        pathPoints.append(CLLocationCoordinate2DMake(41.253896, -72.995046))
        /*pathPoints.append(CLLocationCoordinate2DMake())
        pathPoints.append(CLLocationCoordinate2DMake())
        pathPoints.append(CLLocationCoordinate2DMake())
        pathPoints.append(CLLocationCoordinate2DMake())
        pathPoints.append(CLLocationCoordinate2DMake())
        pathPoints.append(CLLocationCoordinate2DMake())
        pathPoints.append(CLLocationCoordinate2DMake())
        pathPoints.append(CLLocationCoordinate2DMake())
        pathPoints.append(CLLocationCoordinate2DMake())*/
        
        
        path = MKPolyline.init(coordinates: &pathPoints, count: pathPoints.count)
        path.title = "path5"
        map.addOverlay(path)
        
        pathPoints = [CLLocationCoordinate2D]()
        
        
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
            
            polylineRender.strokeColor = UIColor(red:0.00, green: 0.40, blue: 0.00, alpha: 1.0)
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
