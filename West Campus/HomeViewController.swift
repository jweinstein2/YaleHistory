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
    }

    @IBAction func scavengerHuntButtonPressed(sender: AnyObject) {
        if MainModel.scavengerHuntIsSetUp == true {
            let vc = self.storyboard!.instantiateViewControllerWithIdentifier("scavengerHuntViewController") as! ScavengerHuntViewController
            presentViewController(vc, animated: false, completion: nil) //transition to arrival view controller
        }
        else {
            let vc = self.storyboard!.instantiateViewControllerWithIdentifier("sHWelcomeViewController") as! SHWelcomeViewController
            presentViewController(vc, animated: false, completion: nil) //transition to arrival view controller
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
        
        updateBottomNotification(MainModel.projects.nearestProject)
    }
    
    func onNearbyProject(notification: NSNotification){
        //Take Action on Notification
        let proj = notification.object as? Project
        updateBottomNotification(proj)
    }
    
    private func updateBottomNotification (nearbyProj: Project?){
        if !LocationUtil.isLocationAvailable() {
            //Configure notification to alert user that loc is required for awesome experience
            
            let title = "Location is not available"
            let text = "Please allow Yale History app to access your location to provide the most useful possible experience. Thanks"
            let buttonText = "Settings >"
            let instantiateProjectVC = {
                NSLog("Open System Settings")
            }
            setNotification(title, text: text, buttonText: buttonText, action: instantiateProjectVC)
            return
        }
        
        if nearbyProj == nil {
            hideNotification(nil)
            return
        }
        
        let title = "\(nearbyProj!.title) is nearby"
        let text = "\(nearbyProj!.summary)"
        let buttonText = "Learn More >"
        let instantiateProjectVC = {
            NSLog("Transition to \(nearbyProj!.title)")
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
            
            
            //self.topSpacing.constant = -42
            self.bottomNotificationView.hidden = false
            UIView.animateWithDuration(0.5) {
                self.view.layoutIfNeeded()
            }
        }
    }
    
    private func hideNotification(completion: (() -> ())? ) {
        //moves the notification off the screen and then sets it to hidden
        
        if self.bottomNotificationView.hidden == true { completion?() }
        
        
        //self.topSpacing.constant = -42
        UIView.animateWithDuration(0.5) {
            self.view.layoutIfNeeded()
        }
        self.bottomNotificationView.hidden = true
        completion?()
    }
}

