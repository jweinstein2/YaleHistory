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

    var locationManager: CLLocationManager!
    var currProj: Project!
    let regionRadius : Double! = 15.0
    
    //Silliman Courtyard (latitude: 41.31079366, longitude: -72.92481198)
    
    @IBOutlet weak var clueLabel: UILabel!
    @IBOutlet weak var projectTitle: UILabel!
    @IBOutlet weak var distanceLabel: UILabel!
    @IBOutlet weak var Header: UILabel!
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var progressBar: UIProgressView!
    @IBOutlet weak var huntProgress: UILabel!
    @IBOutlet weak var foundIt: UIButton!
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: NSBundle?){
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        
        locationManager = CLLocationManager()               //configure location manager
        locationManager.delegate = self
        locationManager.requestWhenInUseAuthorization()
        locationManager.desiredAccuracy = kCLLocationAccuracyBestForNavigation
        locationManager.distanceFilter = 1
        locationManager.startUpdatingLocation()
        
        NSLog(String(locationManager.activityType))
        
        Header.text = "You are looking for"
        
        //MANUAL CHECK-IN BUTTON
        
        MyViewController.model.currentProject = 0
        currProj = MyViewController.model.projects.projectData[MyViewController.model.currentProject]
        projectTitle.text = currProj.title
        clueLabel.text = "To find this project... " + currProj.clue
        huntProgress.text = "Hunt Progress:"
        
        
        progressBar.setProgress(Float(MyViewController.model.currentProject)/Float(MyViewController.model.projects.projectData.count), animated: false)
        
        let url = NSURL(string: currProj.imageLink!)
        let data = NSData(contentsOfURL:url!)
        if data != nil {
            imageView.image = UIImage(data:data!)
            
        }
        
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        

        if ((MyViewController.model.currentProject + 1) < MyViewController.model.projects.projectData.count){
            
            MyViewController.model.currentProject = MyViewController.model.currentProject + 1 //go to next project
            
            currProj = MyViewController.model.projects.projectData[MyViewController.model.currentProject]   //update currProj
            
        }
            
        else  {     //OTHER CODE FOR FINISHING HUNT
            
            locationManager.stopUpdatingLocation()
            progressBar.setProgress(1.0, animated: false)
            
        }
        
        //IMAGE SETUP
        projectTitle.text = currProj.title
    }
    
    @IBAction func buttonPressed(sender: AnyObject) {
        
        self.dismissViewControllerAnimated(false, completion: nil);
        
    }
    
    @IBAction func foundButtonPressed(sender: AnyObject) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let vc = storyboard.instantiateViewControllerWithIdentifier("arrivalViewController") as! ArrivalViewController
        presentViewController(vc, animated: false, completion: nil) //transition to arrival view controller
    }
    
    func locationManager(manager: CLLocationManager, didUpdateLocations locations: [CLLocation]){
        
        NSLog("%f", currProj.gpsLatitude)
        
        let destLat = currProj.gpsLatitude
        let destLong = currProj.gpsLongitude
        
        let curLat = locations[0].coordinate.latitude
        let curLong = locations[0].coordinate.longitude
        
        let x = 111111*(curLat-destLat)
        
        let y = 111111*(curLong-destLong)
        
        let distance :Double = sqrt(x*x+y*y)
        
        distanceLabel.text = NSString(format: "Distance from project: %.2f", distance) as String
        
        if (distance < regionRadius){
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            let vc = storyboard.instantiateViewControllerWithIdentifier("arrivalViewController") as! ArrivalViewController
            presentViewController(vc, animated: false, completion: nil) //transition to arrival view controller
        }
        
        
        NSLog("update location: %f , %f", locations[0].coordinate.latitude, locations[0].coordinate.longitude)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

    



