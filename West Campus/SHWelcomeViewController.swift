//
//  SHWelcomeViewController.swift
//  West Campus
//
//  Created by Tom Chu on 12/3/15.
//  Copyright © 2015 ENAS118. All rights reserved.
//

import UIKit

class SHWelcomeViewController: MyViewController {

    @IBOutlet weak var toHunt: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        MyViewController.model.hunt = ScavengerHunt(allProjects: MyViewController.model.projects)
        MyViewController.model.scavengerHuntIsSetUp = true
        
    }
    
    @IBAction func buttonPressed(sender: AnyObject) {
        let vc = self.storyboard!.instantiateViewControllerWithIdentifier("scavengerHuntViewController") as! ScavengerHuntViewController
        self.dismissViewControllerAnimated(false, completion: nil)
        NSLog("Got past dismissal")
        presentViewController(vc, animated: false, completion: nil)
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}
