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
    @IBOutlet weak var backgroundImage: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var distanceLabel: UILabel!
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        NSLog("custom init")
    }
    
    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)!
    }
}
