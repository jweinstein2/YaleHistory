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
        
    }
    
    override func viewWillAppear(animated: Bool) {
        if (MyViewController.model.scavengerHuntIsSetUp == true){
            self.dismissViewControllerAnimated(false, completion: nil);
        }
    }
    
    @IBAction func buttonPressed(sender: AnyObject) {
        MyViewController.model.scavengerHuntIsSetUp = true
       
        let vc = self.storyboard!.instantiateViewControllerWithIdentifier("scavengerHuntViewController") as! ScavengerHuntViewController
        presentViewController(vc, animated: false, completion: nil)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}
