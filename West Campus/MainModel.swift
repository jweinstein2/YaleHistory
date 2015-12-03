//
//  MainModel.swift
//  West Campus
//
//  Created by jared weinstein on 11/7/15.
//  Copyright © 2015 ENAS118. All rights reserved.
//
import UIKit
import Foundation

class MainModel{
    var projects : ProjectData!
    var currentProject : Int!
    var scavengerHuntAvailable: Bool!
    var scavengerHuntProgress: Int!
    var sHtransition: Bool!

    var myHTMLString: String?

    init(){
        currentProject = 0;
        let myURLString = "http://contripity.net/wildwest/researchprojects.php"
        
        if let myURL = NSURL(string: myURLString) {
            
            do{
                myHTMLString = try NSString(contentsOfURL: myURL, encoding: NSUTF8StringEncoding) as String
            }catch{
                NSLog("ERROR: Line 21 of Main Model - Failed to download the contents of json from website")
            }
            projects = ProjectData(inputString: myHTMLString!)
            
            if projects.projectData.count == 0 {        //set availability of scavenger hunt
                scavengerHuntAvailable = false
            }
            else {
                scavengerHuntAvailable = true
                scavengerHuntProgress = 0
                sHtransition = false
            }
            
        } else {
            NSLog("Error: \(myURLString) doesn't seem to be a valid URL")
        }
    }
    
    func getCurrentProject() -> Project{
        return projects.projectData[currentProject]
    }
}
