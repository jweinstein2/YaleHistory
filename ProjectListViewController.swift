//
//  MapViewController.swift
//  West Campus
//
//  Created by jared weinstein on 11/3/15.
//  Copyright © 2015 ENAS118. All rights reserved.
//


//Need to complete step seven to make sure that the google link doesnt throw and exception https://developers.google.com/maps/documentation/ios-sdk/start?hl=en

//TODO: THE GOOGLE MAP EVENTUALLY NEEDS TO BE ADDED TO A SEPERATE VIEW SO THAT IT DOESNT TAKE UP THE ENTIRE SCREEN (This looks like its going to create an issue possibly large enough to necessitate a switch to apple maps. From what I'm seeing online there is no way that you can get a marker to lead you to a custom view that you made. PS http://www.raywenderlich.com/109888/google-maps-ios-sdk-tutorial may offer a valid solution)

import UIKit
import Foundation

class MapViewController: MyViewController {
    
    @IBAction func buttonPressed(sender: AnyObject) {
        self.dismissViewControllerAnimated(false, completion: nil);
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.   
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
}

