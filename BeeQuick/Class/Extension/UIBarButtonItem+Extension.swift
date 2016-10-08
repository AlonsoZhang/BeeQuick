//
//  UIBarButtonItem+Extension.swift
//  BeeQuick
//
//  Created by Alonso on 16/10/5.
//  Copyright © 2016年 Alonso. All rights reserved.
//

import UIKit

enum ItemButtonType: Int {
    case Left = 0
    case Right = 1
}

extension UIBarButtonItem {
    
    class func barButton(title: String, titleColor: UIColor, image: UIImage, hightLightImage: UIImage?, target: AnyObject?, action: Selector, type: ItemButtonType) -> UIBarButtonItem {
        var btn:UIButton = UIButton()
        if type == ItemButtonType.Left {
            btn = ItemLeftButton(type: .custom)
        } else {
            btn = ItemRightButton(type: .custom)
        }
        btn.setTitle(title, for: .normal)
        btn.setImage(image, for: .normal)
        btn.setTitleColor(titleColor, for: .normal)
        btn.setImage(hightLightImage, for: .highlighted)
        btn.addTarget(target, action: action, for: .touchUpInside)
        btn.frame = CGRect(x:0, y:0, width:60, height:44)
        btn.titleLabel?.font = UIFont.systemFont(ofSize: 10)
        
        return UIBarButtonItem(customView: btn)
    }
}
