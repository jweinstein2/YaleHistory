//
//  SHWelcomeViewController.swift
//  West Campus
//
//  Created by Tom Chu on 12/3/15.
//  Copyright © 2015 ENAS118. All rights reserved.
//

import UIKit

class SHWelcomeViewController: MyViewController {
    
    var stage: Int!
    
    @IBOutlet weak var announcement: UILabel!
    @IBOutlet weak var tag1: UILabel!
    @IBOutlet weak var tag2: UILabel!
    @IBOutlet weak var tag3: UILabel!
    @IBOutlet weak var nextLabel: UILabel!
    @IBOutlet weak var previousLabel: UILabel!
    @IBOutlet weak var switch1: UISwitch!
    @IBOutlet weak var switch2: UISwitch!
    @IBOutlet weak var switch3: UISwitch!
    @IBOutlet weak var next: UIButton!
    @IBOutlet weak var previous: UIButton!
    @IBOutlet weak var directions: UILabel!
    
    //Add label and switch for randomized
    
    override func viewDidLoad() {
        super.viewDidLoad()
        stage = 0
        
        
    }
    
    override func viewWillAppear(animated: Bool) {
        if (MyViewController.model.scavengerHuntIsSetUp == true){
            self.dismissViewControllerAnimated(false, completion: nil);
        }
    }
    
    @IBAction func buttonPressed(sender: AnyObject) {
        if stage == 0{
            tag1.hidden = false
            tag2.hidden = false
            tag3.hidden = false
            switch1.hidden = false
            switch2.hidden = false
            switch3.hidden = false
            previous.hidden = false
            previousLabel.hidden = false
            
            directions.hidden = true
            
        }
        else {
            MyViewController.model.hunt = ScavengerHunt(allProjects: MyViewController.model.projects, tag1: switch1.selected, tag2: switch2.selected, tag3: switch3.selected, random: false)
            MyViewController.model.scavengerHuntIsSetUp = true
        
            let vc = self.storyboard!.instantiateViewControllerWithIdentifier("scavengerHuntViewController") as! ScavengerHuntViewController
            presentViewController(vc, animated: false, completion: nil)
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}
