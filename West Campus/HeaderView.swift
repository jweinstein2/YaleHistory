//
//  HeaderView.swift
//  Yale History
//
//  Created by jared weinstein on 8/24/16.
//  Copyright © 2016 ENAS118. All rights reserved.
//

import Foundation
import UIKit

@IBDesignable
public class HeaderView : UIView {
    @IBInspectable public var title: String = "Yale History" {
        didSet {
            self.view.titleLabel.text = title.uppercaseString
        }
    }
    @IBInspectable public var shouldDisplayBackButton: Bool = true {
        didSet {
            if shouldDisplayBackButton == true {
                
            } else {
                self.view.backButton.hidden = true
                //TODO change this from being hardcoded
                self.view.leadingSpaceConstraint.constant = -20
                self.layoutIfNeeded()
            }
        }
    }
    
    //private var textFieldDelegate : UITextFieldDelegate
    private var view: HeaderXIBView!
    private let nibName: String = "HeaderView"
    var backActions : () -> () = {}
    
    override public func layoutSubviews() {
        super.layoutSubviews()
        if view == nil {
            xibSetup()
        }
    }
    
    override init(frame: CGRect) {
        // 1. setup any properties here
        super.init(frame: frame)
        xibSetup()
    }
    
    required public init?(coder aDecoder: NSCoder) {
        // 1. setup any properties here
        super.init(coder: aDecoder)
        xibSetup()
    }
    
    override public func prepareForInterfaceBuilder() {
        super.prepareForInterfaceBuilder()
    }
    
    private func xibSetup() {
        view = loadViewFromNib()
        //Configure view properties
        view.backButton.addTarget(self, action: #selector(HeaderView.btnClick(_:)), forControlEvents: UIControlEvents.TouchUpInside)
        
        // use bounds not frame or it'll be offset
        view.frame = bounds
        
        // Make the view stretch with containing view
        view.autoresizingMask = [UIViewAutoresizing.FlexibleWidth, UIViewAutoresizing.FlexibleHeight]
        addSubview(view)
    }
    
    func loadViewFromNib() -> HeaderXIBView {
        let bundle = NSBundle(forClass: self.dynamicType)
        let nib = UINib(nibName: "HeaderView", bundle: bundle)
        let view = nib.instantiateWithOwner(self, options: nil)[0] as! HeaderXIBView
        view.frame = bounds
        view.autoresizingMask = [.FlexibleWidth, .FlexibleHeight]
        
        //Hardcoded font sizes based on iPhone size 
        var fontSize : CGFloat = 21.0
        switch Utility.currentPhone() {
        case .iPhone4:
            fontSize = 16.0
            //self.titleLabel.font =
            break
        case .iPhone5:
            fontSize = 18.0
            break
        case .iPhone6:
            fontSize = 21.0
            break
        case .iPhone6Plus:
            fontSize = 24.0
            break
        case .unknown:
            NSLog("Error: unknown phone size when caclulating header font size")
        }
        view.titleLabel.font = view.titleLabel.font.fontWithSize(fontSize)
        //Set the font size of the label
        
        
        return view
    }
    
    @objc func btnClick(sender: UIButton) {
        //Pop the viewController if possible
        backActions()
        self.getParentViewController()?.navigationController?.popViewControllerAnimated(true)
    }
}

class HeaderXIBView: UIView {
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var backButton: UIButton!
    
    @IBOutlet weak var leadingSpaceConstraint: NSLayoutConstraint!
}