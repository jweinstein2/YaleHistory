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
    @IBOutlet weak var bottomNotificationView: UIView!
    @IBOutlet weak var projectInformation: UIButton!

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
    
    func onNearbyProject(notification: NSNotification){
        //Take Action on Notification
        let proj = notification.object as? Project
        
        if proj == nil {
            //self.topSpacing.constant = -42
            UIView.animateWithDuration(0.5) {
                self.view.layoutIfNeeded()
            }
            self.bottomNotificationView.hidden = true
        } else {
            //self.topSpacing.constant = -42
            UIView.animateWithDuration(0.5) {
                self.view.layoutIfNeeded()
            }
            self.bottomNotificationView.hidden = false
            NSLog("You have walked near \(proj?.title)")
        }
        //TODO - have a little pop up displaying nearby projects
    }
}

