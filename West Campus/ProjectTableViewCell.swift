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
    
    var eventName: UILabel = UILabel()
    var eventCity: UILabel = UILabel()
    var eventTime: UILabel = UILabel()
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        NSLog("custom init")
        
        //Custom initialization for a cell with information in it
        
        
        /*
        self.contentView.addSubview(eventName)
        self.contentView.addSubview(eventCity)
        self.contentView.addSubview(eventTime)
        */
    }
    
    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)!
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        NSLog("layout subview")
        
        /*
        eventName = UILabel(frame: CGRectMake(20, 10, self.bounds.size.width - 40, 25))
        eventCity = UILabel(frame: CGRectMake(0, 0, 0, 0))
        eventTime = UILabel(frame: CGRectMake(0, 0, 0, 0))
        */
        
    }
}
