//
//  SHFinishViewController.swift
//  Yale History
//
//  Created by jared weinstein on 8/28/16.
//  Copyright © 2016 ENAS118. All rights reserved.
//

import Foundation
import UIKit

class SHFinishViewController: MyViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func finishButtonPressed(sender: UIButton) {
        MainModel.hunt = nil
        self.navigationController?.popViewControllerAnimated(true)
    }
}
