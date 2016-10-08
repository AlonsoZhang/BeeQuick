//
//  HotView.swift
//  BeeQuick
//
//  Created by Alonso on 16/10/6.
//  Copyright © 2016年 Alonso. All rights reserved.
//

import UIKit

class HotView: UIView {
    
    private let iconW = (ScreenWidth - 2 * HotViewMargin) * 0.25
    private let iconH: CGFloat = 80
    
    var iconClick:((_ index: Int) -> Void)?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    convenience init(frame: CGRect, iconClick: @escaping ((_ index: Int) -> Void)) {
        self.init(frame:frame)
        self.iconClick = iconClick
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: 模型的Set方法
    var headData: HeadData? {
        didSet {
            print(headData)
            
            if (headData?.icons?.count)! > 0 {
                
                if headData!.icons!.count % 4 != 0 {
                    self.rows = headData!.icons!.count / 4 + 1
                } else {
                    self.rows = headData!.icons!.count / 4
                }
                var iconX: CGFloat = 0
                var iconY: CGFloat = 0
                
                for i in 0..<headData!.icons!.count {
                    iconX = CGFloat(i % 4) * iconW + HotViewMargin
                    iconY = iconH * CGFloat(i / 4)
                    let icon = IconImageTextView(frame: CGRect(x:iconX, y:iconY, width:iconW, height:iconH), placeholderImage: UIImage(named: "icon_icons_holder")!)
                    icon.tag = i
                    icon.activitie = headData!.icons![i]
                    let tap = UITapGestureRecognizer(target: self, action: Selector(("iconClick:")))
                    icon.addGestureRecognizer(tap)
                    addSubview(icon)
                }
            }
        }
    }
    // MARK: rows数量
    private var rows: Int = 0 {
        willSet {
            bounds = CGRect(x:0, y:0, width:ScreenWidth, height:iconH * CGFloat(newValue))
        }
    }
    
    // MARK:- Action
    func iconClick(tap: UITapGestureRecognizer) {
        if iconClick != nil {
            iconClick!(tap.view!.tag)
        }
    }
}
