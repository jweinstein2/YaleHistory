//
//  ViewController.swift
//  West Campus
//
//  Created by Tom Chu on 12/1/15.
//  Copyright © 2015 ENAS118. All rights reserved.
//

import UIKit

class ArrivalViewController: MyViewController {
    let scavengerHunt = MainModel.hunt!
    
    @IBOutlet weak var header: HeaderView!
    @IBOutlet weak var announcement: UILabel!
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var summaryLabel: UILabel!
    @IBOutlet weak var MoreInfo: UIButton!
    var currProj: Project!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        currProj = scavengerHunt.currentProject
        imageView.image = ImageUtil.imageFromURL(currProj.imageLink)
        
        announcement.text = "You have reached " + currProj.title
        //projectTitle.text = currProj.title
        summaryLabel.text = currProj.theBuilding
        
        header.backActions = { self.scavengerHunt.transition = true }
    }

    @IBAction func moreInfoPressed(sender: AnyObject) {     //go to projectViewController
        let vc = self.storyboard!.instantiateViewControllerWithIdentifier("projectViewController") as! ProjectViewController
        vc.project = scavengerHunt.projects[scavengerHunt.progress]
        self.navigationController?.pushViewController(vc, animated: true)
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
