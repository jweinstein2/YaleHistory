//
//  ScavengerHuntViewController.swift
//  West Campus
//
//  Created by jared weinstein on 11/3/15.
//  Copyright © 2015 ENAS118. All rights reserved.
//

import UIKit
import Foundation
import MapKit
import CoreLocation

class ScavengerHuntViewController: MyViewController {

    var mapShown: Bool!
    var currProj: Project!
    let regionRadius : Double! = 15.0
    var projectList : [Project]!
    
    //Silliman Courtyard (latitude: 41.31079366, longitude: -72.92481198)
    
    //@IBOutlet weak var locationLabel: UILabel! //for testing purposes
    @IBOutlet weak var clueLabel: UILabel!
    @IBOutlet weak var projectTitle: UILabel!
    @IBOutlet weak var mapImageButton: UIButton!
    @IBOutlet weak var distanceLabel: UILabel!
    @IBOutlet weak var Header: UILabel!
    @IBOutlet weak var map: UIView!
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var progressBar: UIProgressView!
    @IBOutlet weak var huntProgress: UILabel!
    @IBOutlet weak var foundIt: UIButton!
    @IBOutlet weak var nextLabel: UILabel!
    @IBOutlet weak var previousButton: UIButton!
    @IBOutlet weak var previousLabel: UILabel!

    @IBAction func mapImageTogglePressed(sender: AnyObject) {
        if mapShown==true {
            mapShown = false
            map.hidden = true
            imageView.hidden = false
            mapImageButton.setBackgroundImage(UIImage(named: "image_light"), forState: UIControlState.Normal)
        }else{
            mapShown = true
            map.hidden = true
            imageView.hidden = false
            mapImageButton.setBackgroundImage(UIImage(named: "map_light"), forState: UIControlState.Normal)
        }
        
    }

    
    override func viewDidLoad() {
        super.viewDidLoad()
        MainModel.currentProject = MainModel.hunt.progress
        projectList = MainModel.hunt.projects.projectData
        currProj = projectList[MainModel.currentProject]
        
        Header.text = "You are looking for"
        clueLabel.text = "Clue: " + currProj.clue
        projectTitle.text = currProj.title
        imageView.image = ImageUtil.imageFromURL(currProj.imageLink)
        
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let vc = storyboard.instantiateViewControllerWithIdentifier(vcIdentifiers.mapVC) as! MapViewController
        vc.displayData = [(MKPinAnnotationView.redPinColor(), MainModel.hunt.projects.projectData)]
        vc.shouldDisplayUsersLocation = true
        map.addSubview(vc.view)
        self.addChildViewController(vc)
        map.layoutIfNeeded()
        vc.view.frame = map.bounds
        imageView.hidden = true
        mapShown = true
        
        
        
        progressBar.setProgress(Float(MainModel.currentProject)/Float(MainModel.hunt.projects.projectData.count), animated: false)
        
        //hide previous button if necessary
        if MainModel.hunt.progress == 0 {
            previousButton.hidden = true
            previousLabel.hidden = true
        }
        else{
            previousButton.hidden = false
            previousLabel.hidden = false
        }
        
        //Subscribe to location update notification
        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(self.onLocUpdate(_:)), name: GlobalNotificationKeys.locationUpdate, object: nil)
    }
    
    override func viewWillAppear(animated: Bool) {
        if (MainModel.hunt.transition == true && (MainModel.currentProject + 1) < MainModel.hunt.projects.projectData.count){
            
            MainModel.currentProject = MainModel.currentProject + 1 //go to next project
            MainModel.hunt.progress = MainModel.currentProject
            
            currProj = MainModel.hunt.projects.projectData[MainModel.currentProject]  //update currProj
                      
            if MainModel.hunt.progress == 0 {
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
            clueLabel.text = "Clue: " + currProj.clue
            projectTitle.text = currProj.title
            imageView.image = ImageUtil.imageFromURL(currProj.imageLink)
            
            //update progress bar
            progressBar.setProgress(Float(MainModel.currentProject)/Float(MainModel.hunt.projects.projectData.count), animated: false)
            
        }
            
        else if (MainModel.hunt.transition == true) {
            
            progressBar.setProgress(1.0, animated: false)
            MainModel.hunt.progress = -1
            MainModel.scavengerHuntIsSetUp = false
            
            Header.text = "Congratulations!"
            projectTitle.text = "You've finished the hunt!"
            clueLabel.text = "Click the top left arrow to return to the Main Menu"
            distanceLabel.hidden = true
            foundIt.hidden = true
            nextLabel.hidden = true
            previousButton.hidden = true
            previousLabel.hidden = true
            imageView.image = ImageUtil.imageFromURL("http://www.cwu.edu/~jonase/goodjob.jpg")
        }
        
        MainModel.hunt.transition = false

    }
    
    @IBAction func buttonPressed(sender: AnyObject) {
        self.dismissViewControllerAnimated(false, completion: nil);
    }
    
    @IBAction func foundButtonPressed(sender: AnyObject) {
        MainModel.hunt.transition = true
        viewWillAppear(false)
    }
    
    @IBAction func previousButtonPressed(sender: AnyObject) {
        MainModel.currentProject = MainModel.currentProject - 2

        MainModel.hunt.transition = true
        viewWillAppear(false)
    }
    
    func onLocUpdate(notification: NSNotification){        
        //Take Action on Notification
        let userLoc = notification.object as! CLLocation
        let distance = currProj.location.distanceFromLocation(userLoc)
        self.distanceLabel.text = distance.toString()
        
        if (distance < Double(currProj.radius)){
            let vc = self.storyboard!.instantiateViewControllerWithIdentifier("arrivalViewController") as! ArrivalViewController
            presentViewController(vc, animated: false, completion: nil) //transition to arrival view controller
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
}





