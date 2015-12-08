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
    @IBOutlet weak var randomLabel: UILabel!
    @IBOutlet weak var switch3: UISwitch!
    @IBOutlet weak var next: UIButton!
    @IBOutlet weak var previous: UIButton!
    @IBOutlet weak var directions: UILabel!
    @IBOutlet weak var vertStackView: UIStackView!
    @IBOutlet weak var hoStack1: UIStackView!
    @IBOutlet weak var hoStack2: UIStackView!
    @IBOutlet weak var hoStack3: UIStackView!
    @IBOutlet weak var randomSwitch: UISwitch!
    @IBOutlet weak var hoStack4: UIStackView!
    @IBOutlet weak var buttonHoStack: UIStackView!
    
    //Add label and switch for randomized
    
    override func viewDidLoad() {
        super.viewDidLoad()
        stage = 0
        vertStackView.spacing = 20
        hoStack1.spacing = 40
        hoStack2.spacing = 40
        hoStack3.spacing = 40
        hoStack4.spacing = 40
        buttonHoStack.spacing = 40
        
        setStage(true)
        
    }
    
    override func viewWillAppear(animated: Bool) {
        if (MyViewController.model.scavengerHuntIsSetUp == true){
            self.dismissViewControllerAnimated(false, completion: nil);
        }
    }
    
    @IBAction func backButtonPressed(sender: AnyObject) {
        self.dismissViewControllerAnimated(false, completion: nil);
    }
    
    @IBAction func previousButtonPressed(sender: AnyObject) {
        stage = 0
        setStage(true)
    }
    
    @IBAction func nextbuttonPressed(sender: AnyObject) {
        if stage == 0{
            setStage(false)
            stage = 1
        }
        else if (!switch1.on && !switch2.on && !switch3.on) { //if they selected no projects, send error
            announcement.text = "Sorry, please select at least one tag to move forward"
        }
        else {
            MyViewController.model.hunt = ScavengerHunt(allProjects: MyViewController.model.projects, /*forestry:  switch1.on, sustainability:  switch2.on, construction: switch3.on,*/ random: randomSwitch.on)
            MyViewController.model.scavengerHuntIsSetUp = true
        
            let vc = self.storyboard!.instantiateViewControllerWithIdentifier("scavengerHuntViewController") as! ScavengerHuntViewController
            presentViewController(vc, animated: false, completion: nil)
        }
    }
    
    func setStage(stageIs0: Bool){
        tag1.hidden = stageIs0
        tag2.hidden = stageIs0
        tag3.hidden = stageIs0
        randomLabel.hidden = stageIs0
        switch1.hidden = stageIs0
        switch2.hidden = stageIs0
        switch3.hidden = stageIs0
        randomSwitch.hidden = stageIs0
        previous.hidden = stageIs0
        previousLabel.hidden = stageIs0
        
        directions.hidden = !stageIs0
        
        if stageIs0 {
            announcement.text = "Welcome to the Scavenger Hunt!"
        }
        else{
            announcement.text = "I want to see projects that relate to:"
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}
