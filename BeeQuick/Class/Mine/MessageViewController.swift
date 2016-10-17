//
//  MessageViewController.swift
//  BeeQuick
//
//  Created by Alonso on 16/10/17.
//  Copyright © 2016年 Alonso. All rights reserved.
//

import UIKit

class MessageViewController: BaseViewController {

    var segment: UISegmentedControl!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        bulidSegmentedControl()
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(false, animated: true)
    }
    
    private func bulidSegmentedControl() {
        segment = UISegmentedControl(items: ["系统消息", "用户消息"])
        segment.frame = CGRectMake(0, 0, 180, 30)
        navigationItem.titleView = segment
        navigationItem.titleView?.frame = CGRectMake(0, 0, 180, 30)
        segment.tintColor = LFBNavigationYellowColor
        segment.setTitleTextAttributes([NSForegroundColorAttributeName : UIColor.blackColor()], forState: UIControlState.Selected)
        segment.setTitleTextAttributes([NSForegroundColorAttributeName : UIColor.lightGrayColor()], forState: UIControlState.Normal)
        segment.selectedSegmentIndex = 0
    }
}
