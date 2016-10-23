//
//  LFBSegmentedControl.swift
//  BeeQuick
//
//  Created by Alonso on 2016/10/23.
//  Copyright © 2016年 Alonso. All rights reserved.
//

import UIKit

class LFBSegmentedControl: UISegmentedControl {

    var segmentedClick:((_ index: Int) -> Void)?
    
    override init(items: [Any]?) {
        super.init(items: items)
        tintColor = LFBNavigationYellowColor
        setTitleTextAttributes([NSForegroundColorAttributeName : UIColor.black], for: UIControlState.selected)
        setTitleTextAttributes([NSForegroundColorAttributeName : UIColor.colorWithCustom(r: 100, g: 100, b: 100)], for: UIControlState.normal)
        addTarget(self, action: #selector(LFBSegmentedControl.segmentedControlDidValuechange(sender:)), for: UIControlEvents.valueChanged)
        selectedSegmentIndex = 0
    }
    
    convenience init(items: [AnyObject]?, didSelectedIndex: @escaping (_ index: Int) -> ()) {
        self.init(items: items)
        
        segmentedClick = didSelectedIndex
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    func segmentedControlDidValuechange(sender: UISegmentedControl) {
        if segmentedClick != nil {
            segmentedClick!(sender.selectedSegmentIndex)
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
