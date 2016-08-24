//
//  ViewController.swift
//  West Campus
//
//  Created by jared weinstein on 11/3/15.
//  Copyright © 2015 ENAS118. All rights reserved.
//

import UIKit
import Foundation
import CoreLocation

class ViewController: MyViewController {
    @IBOutlet weak var guidedTourButton: UIButton!
    @IBOutlet weak var guidedTourImage: UIImageView!
    
    @IBOutlet weak var notificationCenterConstraint: NSLayoutConstraint!
    
    @IBOutlet weak var scavengerHunt: UIButton!
    @IBOutlet weak var projectInformation: UIButton!
    
    @IBOutlet weak var bottomNotificationView: UIView!
    @IBOutlet weak var notificationTitle: UILabel!
    @IBOutlet weak var notificationText: UILabel!
    @IBOutlet weak var notificationButton: UIButton!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        bottomNotificationView.layer.cornerRadius = 5;
        bottomNotificationView.layer.masksToBounds = true
        bottomNotificationView.layer.borderWidth = 2
        bottomNotificationView.layer.borderColor = UIColor.whiteColor().CGColor
        
        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(self.onNearbyProject(_:)), name: GlobalNotificationKeys.onNearbyProject, object: nil)
         NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(self.onLocationPermissionsChanged(_:)), name: GlobalNotificationKeys.locationPermissionStatusChange, object: nil)
        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(self.onNoData(_:)), name: GlobalNotificationKeys.noData, object: nil)
    }

    @IBAction func scavengerHuntButtonPressed(sender: AnyObject) {
        if MainModel.hunt != nil {
            let vc = self.storyboard!.instantiateViewControllerWithIdentifier("scavengerHuntViewController") as! ScavengerHuntViewController
            self.navigationController?.pushViewController(vc, animated: true)
        }
        else {
            let vc = self.storyboard!.instantiateViewControllerWithIdentifier("sHWelcomeViewController") as! SHWelcomeViewController
            self.navigationController?.pushViewController(vc, animated: true)
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        /*if (segue.identifier == "Load View") {
            // pass data to next view
        }*/
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        if LocationUtil.isLocationAvailable() {
            guidedTourButton.alpha = 1.0
            guidedTourImage.alpha = 1.0
        } else {
            guidedTourButton.alpha = 0.4
            guidedTourImage.alpha = 0.4
        }
        guidedTourButton.enabled = LocationUtil.isLocationAvailable()
        updateBottomNotification(MainModel.projects.nearestProject)
    }
    
    func onLocationPermissionsChanged(notification: NSNotification) {
        guidedTourButton.enabled = LocationUtil.isLocationAvailable()
        if LocationUtil.isLocationAvailable() {
            guidedTourButton.alpha = 1.0
            guidedTourImage.alpha = 1.0
        } else {
            guidedTourButton.alpha = 0.4
            guidedTourImage.alpha = 0.4
        }
        updateBottomNotification(MainModel.projects.nearestProject)
    }
    
    func onNoData(notification: NSNotification) {
        let title = "College data could not be accessed"
        let text = "Please check your network settings and try again later."
        let buttonText = ""
        let instantiateProjectVC = { }
        setNotification(title, text: text, buttonText: buttonText, action: instantiateProjectVC)
        return
    }
    
    func onNearbyProject(notification: NSNotification){
        //Take Action on Notification
        let proj = notification.object as? Project
        updateBottomNotification(proj)
    }
    
    private func updateBottomNotification (nearbyProj: Project?){
        if !LocationUtil.isLocationAvailable() {
            NSLog("LOCATION NOT AVALIBLE ")
            //Configure notification to alert user that loc is required for awesome experience
            
            let title = "Location is not available"
            let text = "Please allow Yale History app to access your location to provide the most useful possible experience. Thanks"
            let buttonText = "Settings >"
            let instantiateProjectVC = {
                NSLog("Open System Settings")
                UIApplication.sharedApplication().openURL(NSURL(string:UIApplicationOpenSettingsURLString)!)
            }
            setNotification(title, text: text, buttonText: buttonText, action: instantiateProjectVC)
            return
        }
        
        if nearbyProj == nil {
            hideNotification(nil)
            return
        }
        
        let title = "\(nearbyProj!.title) is nearby"
        let text = "\(nearbyProj!.theNamesake)"
        let buttonText = "Learn More >"
        let instantiateProjectVC = {
            let proj = nearbyProj
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            let vc = storyboard.instantiateViewControllerWithIdentifier("projectViewController") as! ProjectViewController
            vc.project = proj
            self.navigationController?.pushViewController(vc, animated: true)
        }
        setNotification(title, text: text, buttonText: buttonText, action: instantiateProjectVC)
    }
    
    private func setNotification(title: String, text: String, buttonText: String, action: () -> ()){
        hideNotification(){
            //On completion
            NSLog("setNotification")
            
            //Set all the properties
            self.notificationTitle.text = title
            self.notificationText.text = text
            self.notificationButton.setTitle(buttonText, forState: .Normal)
            self.notificationButton.actionHandle(controlEvents: UIControlEvents.TouchUpInside,
                ForAction:{() -> Void in
                    action()
            })
            
            
            self.view.layoutIfNeeded()
            UIView.animateWithDuration(0.5) {
                self.notificationCenterConstraint.constant = 0
                self.bottomNotificationView.hidden = false
                self.view.layoutIfNeeded()
            }
        }
    }
    
    private func hideNotification(completion: (() -> ())? ) {
        //moves the notification off the screen and then sets it to hidden
        
        if self.bottomNotificationView.hidden == true { completion?(); return }
        
        self.view.layoutIfNeeded()
        self.notificationCenterConstraint.constant = 300
        UIView.animateWithDuration(0.5) {
            self.view.layoutIfNeeded()
        }
        self.bottomNotificationView.hidden = true
        completion?()
    }
}

