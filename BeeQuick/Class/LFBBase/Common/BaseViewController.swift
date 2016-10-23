//
//  BaseViewController.swift
//  BeeQuick
//
//  Created by Alonso on 16/10/5.
//  Copyright © 2016年 Alonso. All rights reserved.
//

import UIKit

class BaseViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = LFBGlobalBackgroundColor
        navigationItem.hidesBackButton = true
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    deinit {
        print(NSStringFromClass(self.classForCoder) + "--------delloc---------")
    }
}
