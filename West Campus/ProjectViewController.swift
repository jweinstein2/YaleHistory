//
//  ProjectViewController.swift
//  West Campus
//
//  Created by jared weinstein on 11/9/15.
//  Copyright © 2015 ENAS118. All rights reserved.
//

import UIKit
import Foundation
import MapKit

class ProjectViewController: MyViewController {
    var project : Project! //This needs to be set by the calling class when presenting the ProjectViewController
    
    @IBOutlet weak var projImage: UIImageView!
    @IBOutlet weak var projTitle: UILabel!
    @IBOutlet weak var summary: UILabel!
    @IBOutlet weak var linkLabel: UILabel!
    @IBOutlet weak var actionLabel: UILabel!
    @IBOutlet weak var mapContainer: UIView!
    @IBOutlet weak var collegeWebsite: UILabel!
    
    @IBAction func buttonPressed(sender: AnyObject) {
        self.navigationController?.popViewControllerAnimated(true)
    }
    
    override func viewDidLoad() {
        linkLabel.userInteractionEnabled = true
        let tapGesture : UITapGestureRecognizer = UITapGestureRecognizer.init(target: self, action: #selector(self.historyTapped))
        linkLabel.addGestureRecognizer(tapGesture)
        actionLabel.text = project.theNamesake
        linkLabel.text = "History of " + project.namesakeName + " >"
        
        if project.collegeWebsite != ""{
            
        collegeWebsite.userInteractionEnabled = true
        let tapGesture2 : UITapGestureRecognizer = UITapGestureRecognizer.init(target: self, action: #selector(self.websiteTapped))
        collegeWebsite.addGestureRecognizer(tapGesture2)
        collegeWebsite.text = project.title + " Website >"
        }
        else{
            collegeWebsite.userInteractionEnabled = false
            collegeWebsite.text = "Website Currently Unavailable"
            collegeWebsite.alpha = 0.4
        }
        
        super.viewDidLoad()
        projTitle.text = project.title.capitalizedString
        summary.text = project.theBuilding
        
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let vc = storyboard.instantiateViewControllerWithIdentifier(vcIdentifiers.mapVC) as! MapViewController
        vc.displayData = [(UIColor.blueColor(), [project])]
        vc.view.frame = CGRectMake(0, 0, mapContainer.frame.size.width, mapContainer.frame.size.height)
        mapContainer.addSubview(vc.view)
        mapContainer.bringSubviewToFront(vc.view)
        
        //Edit the code below to display a custom image for each project
        projImage.image = ImageUtil.imageFromURL(project.imageLink)
 
}

    @IBAction func historyTapped() {
        let url = NSURL(string: project.link)! //this requires a link in the form "html:// ..." doesnt work for just "www.goog..."
        UIApplication.sharedApplication().openURL(url)
    }
    
    @IBAction func websiteTapped() {
        let url = NSURL(string: project.collegeWebsite)! //this requires a link in the form "html:// ..." doesnt work for just "www.goog..."
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
