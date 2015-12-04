//
//  ViewController.swift
//  West Campus
//
//  Created by jared weinstein on 11/3/15.
//  Copyright © 2015 ENAS118. All rights reserved.
//

import UIKit
import Foundation

class ViewController: MyViewController {
    
    @IBOutlet weak var scavengerHunt: UIButton!
    @IBOutlet weak var projectInformation: UIButton!

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        MyViewController.model = MainModel.init()
        //NSLog(String(MyViewController.model))
        
        //make button gray out
        
        //if (!MyViewController.model.scavengerHuntAvailable){
        //   scavengerHunt.enabled = false
       // }
    }

    @IBAction func scavengerHuntButtonPressed(sender: AnyObject) {
        
        if MyViewController.model.scavengerHuntIsSetUp == true {
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
}

