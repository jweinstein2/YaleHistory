//
//  ProjectViewController.swift
//  West Campus
//
//  Created by jared weinstein on 11/9/15.
//  Copyright © 2015 ENAS118. All rights reserved.
//

import UIKit
import Foundation

class ProjectViewController: MyViewController {
    var proj : Project!
    var longitude : Double!
    var latitude : Double!
    
    @IBOutlet weak var projTitle: UILabel!
    @IBOutlet weak var summary: UILabel!
    @IBOutlet weak var linkLabel: UILabel!
    @IBOutlet weak var actionLabel: UILabel!
    @IBOutlet weak var mapContainer: UIView!
    
    @IBAction func buttonPressed(sender: AnyObject) {
        self.dismissViewControllerAnimated(false, completion: nil);
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        proj = MyViewController.model.getCurrentProject()
        projTitle.text = proj.title
        summary.text = proj.summary
        self.longitude = proj.gpsLongitude
        self.latitude = proj.gpsLatitude
        
        
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let vc = storyboard.instantiateViewControllerWithIdentifier("mapViewController") as! MapViewController
        vc.projectsToBeDisplayed = [proj]
        mapContainer.addSubview(vc.view)
        mapContainer.bringSubviewToFront(vc.view)
        
        linkLabel.text = proj.link
        actionLabel.text = proj.action
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}
