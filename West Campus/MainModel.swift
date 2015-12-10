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
    var scavengerHuntIsSetUp: Bool!
    var hunt: ScavengerHunt!
    var prefs : NSUserDefaults = NSUserDefaults.standardUserDefaults()

    var myHTMLString: String?

    init(){
        currentProject = 0;
        let myURLString = "http://contripity.net/wildwest/researchprojects.php"//needs to be changed to where the file is stored that parses our database
        scavengerHuntIsSetUp = false
        
        if let myURL = NSURL(string: myURLString) {
            var failed : Bool = false
            
            do{
                myHTMLString = try NSString(contentsOfURL: myURL, encoding: NSUTF8StringEncoding) as String
            }catch{
                //This catch is called if there was any error downloading the content from the database
                NSLog("ERROR: Line 21 of Main Model - Failed to download the contents of json from website")
                
                failed = true
                self.loadNSUserDefaults()
            }
            
            if failed == false{
                self.downloadData()
            }
            
        } else {
            NSLog("Error: \(myURLString) doesn't seem to be a valid URL")
        }
    }
    
    func getCurrentProject() -> Project{
        return projects.projectData[currentProject]
    }
    
    
    //This method is called when the application fails to connect to the database
    //NOTE: A more comprehensive implementation would use core data. For the sake of speed I'm implementing persistant data using NSUserDefaults instead.
    func loadNSUserDefaults(){
        let json : String = String(prefs.objectForKey("json")) as String!
        if json != "nil"{
            NSLog("Retrieving NSUserDefaults")
            projects = ProjectData(inputString: json)
            prefs.synchronize()
            //Previously saved defaults are avalible
            
        }else{
            NSLog("No Data found. Unable to continue.")
            //No data is found. Need to alert the user that the app is unusable until we connect to data
            
        }
    }
    
    func downloadData(){
        projects = ProjectData(inputString: myHTMLString!)
        
        if projects.projectData.count == 0 {        //set availability of scavenger hunt
            scavengerHuntAvailable = false
        }
        else {
            scavengerHuntAvailable = true
        }
        
        //Save Data as Defaults
        prefs.setObject(myHTMLString!, forKey: "json")
        prefs.synchronize()
    }
}
