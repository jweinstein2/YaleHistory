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

    var myHTMLString: String? = ""

    init(){
        let myURLString = "http://contripity.net/wildwest/researchprojects.php"
        
        if let myURL = NSURL(string: myURLString) {
            
            do{
                myHTMLString = try NSString(contentsOfURL: myURL, encoding: NSUTF8StringEncoding) as String
            }catch{
                NSLog("ERROR: Line 21 of Main Model - Failed to download the contents of json from website")
            }
            NSLog(myHTMLString!)
        } else {
            NSLog("Error: \(myURLString) doesn't seem to be a valid URL")
        }

    }
}
