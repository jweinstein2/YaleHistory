//
//  ProjectTableViewCell.swift
//  West Campus
//
//  Created by jared weinstein on 11/24/15.
//  Copyright © 2015 ENAS118. All rights reserved.
//

import Foundation
import UIKit

class ProjectTableViewCell: UITableViewCell {
    var locationEnabled : Bool?
    var distance : String?
    var distanceLabel: UILabel = UILabel() //not currently used

    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        NSLog("custom init")
        
        if locationEnabled == true {
            //Custom initialization for a cell with distance label in it **NOT USED**
            distanceLabel = UILabel(frame: CGRectMake(self.bounds.size.width - 55, 5, 70, self.bounds.size.height - 10))
            distanceLabel.text = distance
            distanceLabel.textAlignment = NSTextAlignment.Right
            
            self.contentView.addSubview(distanceLabel)
        }
    }
    
    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)!
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        NSLog("layout subview")
    }
}
