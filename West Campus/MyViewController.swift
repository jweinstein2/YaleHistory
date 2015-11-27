//
//  File.swift
//  West Campus
//
//  Created by jared weinstein on 11/9/15.
//  Copyright © 2015 ENAS118. All rights reserved.
//

import Foundation
import UIKit

class MyViewController : UIViewController{
    static var model : MainModel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //This loads a pretty background and adds it to all views
        let imageView = UIImageView(frame: self.view.frame); // set as you want
        let image = UIImage(named: "background");
        imageView.image = image;
        self.view.addSubview(imageView);
        self.view.sendSubviewToBack(imageView)

    }
    
    override func preferredStatusBarStyle() -> UIStatusBarStyle {
        //whether or not the top status bar is white or black
        return UIStatusBarStyle.LightContent
    }
}