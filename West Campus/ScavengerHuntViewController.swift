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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        if (MyViewController.model.currentProject + 1) < MyViewController.model.projects.projectData.count{
            
            if MyViewController.model.scavengerHuntProgress == 0 {
                locationManager = CLLocationManager()               //configure location manager
                locationManager.delegate = self
                locationManager.requestWhenInUseAuthorization()
                locationManager.desiredAccuracy = kCLLocationAccuracyBestForNavigation
                locationManager.distanceFilter = 1
                locationManager.startUpdatingLocation()
                
                NSLog(String(locationManager.activityType))
                
                MyViewController.model.currentProject = 0
            }
            
            else {
                MyViewController.model.currentProject = MyViewController.model.currentProject + 1 //go to next project
            }
            
            currProj = MyViewController.model.projects.projectData[MyViewController.model.currentProject]   //update currProj
            
            
            //set up display
            Header.text = "You are looking for"
            clueLabel.text = "To find this project... " + currProj.clue
            projectTitle.text = currProj.title
            let url = NSURL(string: currProj.imageLink!)
            let data = NSData(contentsOfURL:url!)
            if data != nil {
                imageView.image = UIImage(data:data!)
            }
            
            //update progress bar
            progressBar.setProgress(Float(MyViewController.model.currentProject)/Float(MyViewController.model.projects.projectData.count), animated: false)
            
            MyViewController.model.scavengerHuntProgress = MyViewController.model.currentProject
        }
            
        else  {     //OTHER CODE FOR FINISHING HUNT
            
            locationManager.stopUpdatingLocation()
            progressBar.setProgress(1.0, animated: false)
            MyViewController.model.scavengerHuntProgress = 0
            
            Header.text = "Congratulations, you've finished the hunt!"
            projectTitle.text = "Click the back arrow to return to the main menu"
            clueLabel.hidden = true
            distanceLabel.hidden = true
            
            let url = NSURL(string: "http://www.cwu.edu/~jonase/goodjob.jpg")
            let data = NSData(contentsOfURL:url!)
            if data != nil {
                imageView.image = UIImage(data:data!)
            }
            
        }
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

    



