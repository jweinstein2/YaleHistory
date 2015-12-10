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
    @IBOutlet weak var nextLabel: UILabel!
    @IBOutlet weak var previousButton: UIButton!
    @IBOutlet weak var previousLabel: UILabel!

    
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
        let url = NSURL(string: currProj.imageLink)
        let data = NSData(contentsOfURL:url!)
        if data != nil {
            imageView.image = UIImage(data:data!)
        }
        else{
            imageView.image = UIImage(named: "west_campus_default")
        }
        
        progressBar.setProgress(Float(MyViewController.model.currentProject)/Float(MyViewController.model.hunt.projects.projectData.count), animated: false)
        
        //hide previous button if necessary
        if MyViewController.model.hunt.progress == 0 {
            previousButton.hidden = true
            previousLabel.hidden = true
        }
        else{
            previousButton.hidden = false
            previousLabel.hidden = false
        }
    }
    
    override func viewWillAppear(animated: Bool) {
        if (MyViewController.model.hunt.transition == true && (MyViewController.model.currentProject + 1) < MyViewController.model.hunt.projects.projectData.count){
            
            MyViewController.model.currentProject = MyViewController.model.currentProject + 1 //go to next project
            MyViewController.model.hunt.progress = MyViewController.model.currentProject
            
            currProj = MyViewController.model.hunt.projects.projectData[MyViewController.model.currentProject]  //update currProj
            
            if MyViewController.model.hunt.progress == 0 {
                previousButton.hidden = true
                previousLabel.hidden = true
            }
            else{
                previousButton.hidden = false
                previousLabel.hidden = false
            }
            foundIt.hidden = false
            nextLabel.hidden = false
            
            
            //set up display
            clueLabel.text = "To find this project... " + currProj.clue
            projectTitle.text = currProj.title
            let url = NSURL(string: currProj.imageLink)
            let data = NSData(contentsOfURL:url!)
            if data != nil {
                imageView.image = UIImage(data:data!)
            }
            else{
                imageView.image = UIImage(named: "west_campus_default")
            }
            
            //update progress bar
            progressBar.setProgress(Float(MyViewController.model.currentProject)/Float(MyViewController.model.hunt.projects.projectData.count), animated: false)
            
        }
            
        else if (MyViewController.model.hunt.transition == true) {
            
            progressBar.setProgress(1.0, animated: false)
            MyViewController.model.hunt.progress = -1
            MyViewController.model.scavengerHuntIsSetUp = false
            
            Header.text = "Congratulations!"
            projectTitle.text = "You've finished the hunt!"
            clueLabel.text = "Click the top left arrow to return to the Main Menu"
            distanceLabel.hidden = true
            foundIt.hidden = true
            nextLabel.hidden = true
            previousButton.hidden = true
            previousLabel.hidden = true
            
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
        MyViewController.model.hunt.transition = true
        viewWillAppear(false)
    }
    
    @IBAction func previousButtonPressed(sender: AnyObject) {
        MyViewController.model.currentProject = MyViewController.model.currentProject - 2

        MyViewController.model.hunt.transition = true
        viewWillAppear(false)
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
        
        if (distance < Double(currProj.radius)){
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

    



