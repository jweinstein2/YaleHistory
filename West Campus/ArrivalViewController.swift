//
//  ViewController.swift
//  West Campus
//
//  Created by Tom Chu on 12/1/15.
//  Copyright © 2015 ENAS118. All rights reserved.
//

import UIKit

class ArrivalViewController: UIViewController {

    @IBOutlet weak var back: UIButton!
    @IBOutlet weak var announcement: UILabel!
    @IBOutlet weak var projectTitle: UILabel!
    @IBOutlet weak var summaryLabel: UILabel!
    @IBOutlet weak var MoreInfo: UIButton!
    var currProj: Project!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        currProj = MyViewController.model.projects.projectData[MyViewController.model.currentProject]
        
        announcement.text = "Congratulations! You have reached the site!"
        projectTitle.text = currProj.title
        summaryLabel.text = currProj.summary
    }
    
    
    @IBAction func buttonPressed(sender: AnyObject) {
        
        self.dismissViewControllerAnimated(false, completion: nil);
        
    }


    @IBAction func moreInfoPressed(sender: AnyObject) {     //go to projectViewController
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let vc = storyboard.instantiateViewControllerWithIdentifier("projectViewController") as! ProjectViewController
        presentViewController(vc, animated: false, completion: nil) //transition to arrival view controller
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
