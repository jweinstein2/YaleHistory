//
//  ImageUtil.swift
//  West Campus
//
//  Created by jared weinstein on 7/17/16.
//  Copyright © 2016 ENAS118. All rights reserved.
//

import Foundation
import UIKit

//TODO: Switch this over to UIImage extension
class ImageUtil {
    class func imageFromURL(url: String) -> UIImage {
        let url = NSURL(string: url)
        let data = NSData(contentsOfURL:url!)
        if data != nil {
            return UIImage(data: data!)!
        } else {
            return UIImage(named: "west_campus_default")!
        }
    }
}
