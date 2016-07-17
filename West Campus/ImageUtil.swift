//
//  ImageUtil.swift
//  West Campus
//
//  Created by jared weinstein on 7/17/16.
//  Copyright © 2016 ENAS118. All rights reserved.
//

import Foundation
import UIKit

class ImageUtil {
    static var cachedImages : [String : UIImage] = [:]
    
    //Loads an image from a URLString ("http:/...") and caches it for quick loading the second time
    class func imageFromURL(urlString: String) -> UIImage {
        if let image = cachedImages[urlString] {
            return image
        }
        
        let url = NSURL(string: urlString)
        let data = NSData(contentsOfURL:url!)
        if data != nil {
            let img = UIImage(data: data!)!
            cachedImages[urlString] = img
            return img
        } else {
            return UIImage(named: "west_campus_default")!
        }
    }
}
