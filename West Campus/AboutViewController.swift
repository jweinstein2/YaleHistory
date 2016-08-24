//
//  AboutViewController.swift
//  West Campus
//
//  Created by jared weinstein on 11/7/15.
//  Copyright © 2015 ENAS118. All rights reserved.
//

import UIKit

class AboutViewController: MyViewController {
    
    @IBAction func learnMorePressed(sender: UIButton) {
        let url = NSURL(string: "http://www.yale.edu/about-yale/traditions-history/illuminating-yales-history")!
        UIApplication.sharedApplication().openURL(url)
    }
   
    
    private func openUrl(url:String!) {
        let targetURL=NSURL(fileURLWithPath: url)
        let application=UIApplication.sharedApplication()
        application.openURL(targetURL)
    }
}
