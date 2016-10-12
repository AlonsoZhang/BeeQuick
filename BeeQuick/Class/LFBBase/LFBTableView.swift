//
//  LFBTableView.swift
//  BeeQuick
//
//  Created by Alonso on 16/10/12.
//  Copyright © 2016年 Alonso. All rights reserved.
//

import UIKit

class LFBTableView: UITableView {

    override init(frame: CGRect, style: UITableViewStyle) {
        super.init(frame: frame, style: style)
        
        delaysContentTouches = false
        canCancelContentTouches = true
        separatorStyle = .none
        
        let wrapView = subviews.first
        
        if wrapView != nil && NSStringFromClass((wrapView?.classForCoder)!).hasPrefix("WrapperView") {
            
            for gesture in wrapView!.gestureRecognizers! {
                if (NSStringFromClass(gesture.classForCoder).containsString("DelayedTouchesBegan")) {
                    gesture.isEnabled = false
                    break
                }
            }
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func touchesShouldCancel(in view: UIView) -> Bool {
        if view.isKind(of: UIControl.self) {
            return true
        }
        
        return super.touchesShouldCancel(in: view)
    }
}
