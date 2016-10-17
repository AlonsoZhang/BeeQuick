//
//  BindingCouponView.swift
//  BeeQuick
//
//  Created by Alonso on 16/10/17.
//  Copyright © 2016年 Alonso. All rights reserved.
//

import UIKit

class BindingCouponView: UIView {
    
    var bindingButtonClickBack:((couponTextFiled: UITextField) -> ())?
    
    private lazy var couponTextFiled: UITextField = {
        let couponTextFiled = UITextField()
        
        couponTextFiled.keyboardType = UIKeyboardType.NumberPad
        couponTextFiled.borderStyle = UITextBorderStyle.roundedRect
        couponTextFiled.autocorrectionType = UITextAutocorrectionType.No
        couponTextFiled.font = UIFont.systemFontOfSize(14)
        let placeholder = NSAttributedString(string: "请输入优惠劵号码", attributes: [NSFontAttributeName : UIFont.systemFontOfSize(14), NSForegroundColorAttributeName : UIColor(red: 50 / 255.0, green: 50 / 255.0, blue: 50 / 255.0, alpha: 0.8)])
        
        couponTextFiled.attributedPlaceholder = placeholder
        
        return couponTextFiled
    }()
    
    private lazy var bindingButton: UIButton = {
        let btn = UIButton(type: UIButtonType.Custom)
        btn.layer.masksToBounds = true
        btn.layer.cornerRadius = 5
        btn.backgroundColor = LFBNavigationYellowColor
        btn.setTitle("绑定", forState: UIControlState.Normal)
        btn.setTitleColor(UIColor.blackColor(), forState: UIControlState.Normal)
        btn.titleLabel?.font = UIFont.systemFontOfSize(14)
        btn.addTarget(self, action: "bindingButtonClick", forControlEvents: UIControlEvents.TouchUpInside)
        
        return btn
    }()
    
    private lazy var lineView: UIView = {
        let lineView = UIView()
        lineView.backgroundColor = UIColor.blackColor()
        lineView.alpha = 0.2
        
        return lineView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        addSubview(couponTextFiled)
        addSubview(bindingButton)
        addSubview(lineView)
    }
    
    convenience init(frame: CGRect, bindingButtonClickBack:((couponTextFiled: UITextField) -> ())) {
        self.init(frame: frame)
        
        self.bindingButtonClickBack = bindingButtonClickBack
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        let topBottomMargin: CGFloat = 10
        let bingdingButtonWidth: CGFloat = 60
        couponTextFiled.frame = CGRect(x:CouponViewControllerMargin, y:topBottomMargin, width:width - 2 * CouponViewControllerMargin - bingdingButtonWidth - 10, height:height - 2 * topBottomMargin)
        bindingButton.frame = CGRect(x:width - CouponViewControllerMargin - bingdingButtonWidth, y:topBottomMargin, width:bingdingButtonWidth, height:couponTextFiled.height)
        lineView.frame = CGRect(x:0, y:height - 0.5, width:width, height:0.5)
    }
    
    // MARK: Action
    func bindingButtonClick() {
        if bindingButtonClickBack != nil {
            bindingButtonClickBack!(couponTextFiled: couponTextFiled)
        }
    }
}
