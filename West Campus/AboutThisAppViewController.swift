//
//  AboutThisAppViewController.swift
//  West Campus
//
//  Created by Julia Shan on 12/2/15.
//  Copyright © 2015 ENAS118. All rights reserved.
//

import UIKit
import Foundation

class AboutThisAppViewController: MyViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    
    }
    
    @IBAction func buttonPressed(sender: AnyObject) {
        self.navigationController?.popViewControllerAnimated(true)
    }
    
    @IBAction func learnMorePressed(sender: UIButton) {
        let url = NSURL(string: "http://www.yale.edu/about-yale/traditions-history/illuminating-yales-history")!
        UIApplication.sharedApplication().openURL(url)
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
