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
    
    //@IBOutlet weak var locationLabel: UILabel! //for testing purposes
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
        
        locationManager = CLLocationManager()               //configure location manager
        locationManager.delegate = self
        locationManager.requestWhenInUseAuthorization()
        locationManager.desiredAccuracy = kCLLocationAccuracyBestForNavigation
        locationManager.distanceFilter = 1
        locationManager.startUpdatingLocation()
        
        NSLog(String(locationManager.activityType))
        
        MyViewController.model.currentProject = MyViewController.model.hunt.progress
        currProj = MyViewController.model.hunt.projects.projectData[MyViewController.model.currentProject]
        
        Header.text = "You are looking for"
        clueLabel.text = "To find this project... " + currProj.clue
        projectTitle.text = currProj.title
        let url = NSURL(string: currProj.imageLink!)
        let data = NSData(contentsOfURL:url!)
        if data != nil {
            imageView.image = UIImage(data:data!)
        }
        else {
            let url2 = NSURL(string: "http://photoblogstop.com/wp-content/uploads/2012/07/Sierra_HDR_Panorama_DFX8048_2280x819_Q40_wm_mini.jpg")
            let data2 = NSData(contentsOfURL:url2!)
            if data2 != nil{
                imageView.image = UIImage(data: data2!)
            }
        }

        progressBar.setProgress(Float(MyViewController.model.currentProject)/Float(MyViewController.model.hunt.projects.projectData.count), animated: false)
        
            }
    
    override func viewWillAppear(animated: Bool) {
        if (MyViewController.model.hunt.transition == true && (MyViewController.model.currentProject + 1) < MyViewController.model.hunt.projects.projectData.count){
            
            MyViewController.model.currentProject = MyViewController.model.currentProject + 1 //go to next project
            MyViewController.model.hunt.progress = MyViewController.model.currentProject
            
            currProj = MyViewController.model.hunt.projects.projectData[MyViewController.model.currentProject]  //update currProj
            
            //set up display
            clueLabel.text = "To find this project... " + currProj.clue
            projectTitle.text = currProj.title
            let url = NSURL(string: currProj.imageLink!)
            let data = NSData(contentsOfURL:url!)
            if data != nil {
                imageView.image = UIImage(data:data!)
            }
            else {
                let url2 = NSURL(string: "http://photoblogstop.com/wp-content/uploads/2012/07/Sierra_HDR_Panorama_DFX8048_2280x819_Q40_wm_mini.jpg")
                let data2 = NSData(contentsOfURL:url2!)
                if data2 != nil{
                    imageView.image = UIImage(data: data2!)
                }
            }
            
            //update progress bar
            progressBar.setProgress(Float(MyViewController.model.currentProject)/Float(MyViewController.model.projects.projectData.count), animated: false)
            
        }
            
        else if (MyViewController.model.hunt.transition == true) {
            
            progressBar.setProgress(1.0, animated: false)
            MyViewController.model.hunt.progress = 0
            MyViewController.model.scavengerHuntIsSetUp = false
            
            Header.text = "Congratulations!"
            projectTitle.text = "You've finished the hunt!"
            clueLabel.text = "Click the back arrow to return to the Main Menu"
            distanceLabel.hidden = true
            foundIt.hidden = true
            
            let url = NSURL(string: "http://www.cwu.edu/~jonase/goodjob.jpg")
            let data = NSData(contentsOfURL:url!)
            if data != nil {
                imageView.image = UIImage(data:data!)
            }
            locationManager.stopUpdatingLocation()
        }
        
        MyViewController.model.hunt.transition = false

    }
    
    @IBAction func buttonPressed(sender: AnyObject) {
        
        self.dismissViewControllerAnimated(false, completion: nil);
        
    }
    
    @IBAction func foundButtonPressed(sender: AnyObject) {
        let vc = self.storyboard!.instantiateViewControllerWithIdentifier("arrivalViewController") as! ArrivalViewController
        presentViewController(vc, animated: false, completion: nil) //transition to arrival view controller
    }
    
    func locationManager(manager: CLLocationManager, didUpdateLocations locations: [CLLocation]){
        
        NSLog("%f", currProj.gpsLatitude)
        
        let destLat = currProj.gpsLatitude
        let destLong = currProj.gpsLongitude
        
        let curLat = locations[0].coordinate.latitude
        let curLong = locations[0].coordinate.longitude
        
        //locationLabel.text = "lat: " + String(curLat) + "long: " + String(curLong) //For testing purposes
        
        let x = 111111*(curLat-destLat)
        
        let y = 111111*(curLong-destLong)
        
        let distance :Double = sqrt(x*x+y*y)

        
        distanceLabel.text = NSString(format: "Distance from project: %d m", Int(distance)) as String
        
        if (distance < regionRadius){
            let vc = self.storyboard!.instantiateViewControllerWithIdentifier("arrivalViewController") as! ArrivalViewController
            presentViewController(vc, animated: false, completion: nil) //transition to arrival view controller
        }
        
        NSLog("update location: %f , %f", locations[0].coordinate.latitude, locations[0].coordinate.longitude)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

    



