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
        MyViewController.model1 = MainModel.init()
        NSLog(String(MyViewController.model1))
    }
    
    @IBAction func demoSegue(sender: AnyObject) {
        let storyboard = UIStoryboard(name: "Main", bundle: NSBundle.mainBundle())
        let nextViewController: MyViewController = storyboard.instantiateViewControllerWithIdentifier("projectViewController") as! MyViewController
        presentViewController(nextViewController, animated: false, completion: nil)
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

