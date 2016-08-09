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
    @IBOutlet weak var contributersLabel: UILabel!
    
    @IBAction func buttonPressed(sender: AnyObject) {
        self.navigationController?.popViewControllerAnimated(true)
    }
    
    override func viewDidLoad() {
        linkLabel.userInteractionEnabled = true
        let tapGesture : UITapGestureRecognizer = UITapGestureRecognizer.init(target: self, action: #selector(self.labelTapped))
        linkLabel.addGestureRecognizer(tapGesture)
        
        super.viewDidLoad()
        projTitle.text = project.title.capitalizedString
        summary.text = project.summary
        contributersLabel.text = project.contributors
        
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let vc = storyboard.instantiateViewControllerWithIdentifier(vcIdentifiers.mapVC) as! MapViewController
        vc.displayData = [(MKPinAnnotationView.redPinColor(), [project])]
        vc.view.frame = CGRectMake(0, 0, mapContainer.frame.size.width, mapContainer.frame.size.height)
        mapContainer.addSubview(vc.view)
        mapContainer.bringSubviewToFront(vc.view)
        
        linkLabel.text = "Learn More"
        actionLabel.text = project.action
        
        //Edit the code below to display a custom image for each project
        projImage.image = ImageUtil.imageFromURL(project.imageLink)
        
        
}

    @IBAction func labelTapped() {
        let url = NSURL(string: project.link)! //this requires a link in the form "html:// ..." doesnt work for just "www.goog..."
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
