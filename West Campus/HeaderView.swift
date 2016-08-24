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
            self.view.titleLabel.text = title
        }
    }
    @IBInspectable public var shouldDisplayBackButton: Bool = true {
        didSet {
            self.view.backButton.hidden = true
        }
    }
    
    //private var textFieldDelegate : UITextFieldDelegate!
    private var view: HeaderXIBView!
    private let nibName: String = "HeaderView"
    
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
        return view
    }
}

class HeaderXIBView: UIView {
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var backButton: UIButton!
}