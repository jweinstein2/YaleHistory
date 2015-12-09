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
    
    @IBOutlet weak var projImage: UIImageView!
    @IBOutlet weak var projTitle: UILabel!
    @IBOutlet weak var summary: UILabel!
    @IBOutlet weak var linkLabel: UILabel!
    @IBOutlet weak var actionLabel: UILabel!
    @IBOutlet weak var mapContainer: UIView!
    @IBOutlet weak var contributersLabel: UILabel!
    
    @IBAction func buttonPressed(sender: AnyObject) {
        self.dismissViewControllerAnimated(false, completion: nil);
    }
    
    override func viewDidLoad() {
        linkLabel.userInteractionEnabled = true
        let
        tapGesture : UITapGestureRecognizer = UITapGestureRecognizer.init(target: self, action: "labelTapped")
        linkLabel.addGestureRecognizer(tapGesture)
        
        super.viewDidLoad()
        proj = MyViewController.model.getCurrentProject()
        projTitle.text = proj.title.uppercaseString
        summary.text = proj.summary
        //contributersLabel.text = proj.contributers
        self.longitude = proj.gpsLongitude
        self.latitude = proj.gpsLatitude
        
        
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let vc = storyboard.instantiateViewControllerWithIdentifier("mapViewController") as! MapViewController
        vc.projectsToBeDisplayed = [proj]
        vc.view.frame = CGRectMake(0, 0, mapContainer.frame.size.width, mapContainer.frame.size.height);
        mapContainer.addSubview(vc.view)
        mapContainer.bringSubviewToFront(vc.view)
        
        linkLabel.text = String(stringInterpolation: proj.link)
        actionLabel.text = proj.action
        
        //Edit the code below to display a custom image for each project
        let url = NSURL(string: proj.imageLink!)
        let data = NSData(contentsOfURL:url!)
        if data != nil {
            projImage.image = UIImage(data:data!)
        }
        else {
            let url2 = NSURL(string: "http://photoblogstop.com/wp-content/uploads/2012/07/Sierra_HDR_Panorama_DFX8048_2280x819_Q40_wm_mini.jpg")
            let data2 = NSData(contentsOfURL:url2!)
            if data2 != nil{
                projImage.image = UIImage(data: data2!)
            }
        }

        
}

    @IBAction func labelTapped() {
        NSLog("hello")
        let url = NSURL(string: proj.link)! //this requires a link in the form "html:// ..." doesnt work for just "www.goog..."
        UIApplication.sharedApplication().openURL(url)
    }
    
    func openUrl(url:String!) {
        let targetURL=NSURL(fileURLWithPath: url)
        let application=UIApplication.sharedApplication()
        application.openURL(targetURL)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}
