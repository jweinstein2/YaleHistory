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
    var distance : String?
    var distanceLabel: UILabel = UILabel()

    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        NSLog("custom init")
        
        //Custom initialization for a cell with information in it
        /*
        self.contentView.addSubview(eventName)
        self.contentView.addSubview(eventCity)
        self.contentView.addSubview(eventTime)*/
        
        distanceLabel = UILabel(frame: CGRectMake(self.bounds.size.width - 55, 5, 70, self.bounds.size.height - 10))
        distanceLabel.text = distance
        distanceLabel.textAlignment = NSTextAlignment.Right

        
        self.contentView.addSubview(distanceLabel)
    }
    
    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)!
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        NSLog("layout subview")
    }
}
