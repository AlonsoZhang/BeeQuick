//
//  MineTabeHeadView.swift
//  BeeQuick
//
//  Created by Alonso on 16/10/5.
//  Copyright © 2016年 Alonso. All rights reserved.
//

import UIKit

enum MineHeadViewButtonType: Int {
    case Order = 0
    case Coupon = 1
    case Message = 2
}

class MineTabeHeadView: UIView {
    
    var mineHeadViewClick:((_ type: MineHeadViewButtonType) -> ())?
    private let orderView = MineOrderView()
    private let couponView = MineCouponView()
    private let messageView = MineMessageView()
    private var couponNumber: UIButton?
    private let line1 = UIView()
    private let line2 = UIView()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = UIColor.white
        buildUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        let subViewW = width / 3.0
        orderView.frame = CGRect(x:0, y:0, width:subViewW, height:height)
        couponView.frame = CGRect(x:subViewW, y:0, width:subViewW, height:height)
        messageView.frame = CGRect(x:subViewW * 2, y:0, width:subViewW, height:height)
        couponNumber?.frame = CGRect(x:subViewW * 1.56, y:12, width:15, height:15)
        line1.frame = CGRect(x:subViewW - 0.5,y:height * 0.2, width:1, height:height * 0.6)
        line2.frame = CGRect(x:subViewW * 2 - 0.5, y:height * 0.2, width:1, height:height * 0.6)
    }
    
    func click(tap: UIGestureRecognizer) {
        if mineHeadViewClick != nil {
            
            switch tap.view!.tag {
                
            case MineHeadViewButtonType.Order.rawValue:
                mineHeadViewClick!(MineHeadViewButtonType.Order)
                break
                
            case MineHeadViewButtonType.Coupon.rawValue:
                mineHeadViewClick!(MineHeadViewButtonType.Coupon)
                break
                
            case MineHeadViewButtonType.Message.rawValue:
                mineHeadViewClick!(MineHeadViewButtonType.Message)
                break
                
            default: break
            }
        }
    }
    
    private func buildUI() {
        orderView.tag = 0
        addSubview(orderView)
        
        couponView.tag = 1
        addSubview(couponView)
        
        messageView.tag = 2
        addSubview(messageView)
        
        for index in 0...2 {
            let tap = UITapGestureRecognizer(target: self, action: #selector(MineTabeHeadView.click(tap:)))
            let subView = viewWithTag(index)
            subView?.addGestureRecognizer(tap)
        }
        
        line1.backgroundColor = UIColor.gray
        line1.alpha = 0.3
        addSubview(line1)
        
        line2.backgroundColor = UIColor.gray
        line2.alpha = 0.3
        addSubview(line2)
        
        couponNumber = UIButton(type: .custom)
        couponNumber?.setBackgroundImage(UIImage(named: "redCycle"), for: UIControlState.normal)
        couponNumber?.setTitleColor(UIColor.red, for: .normal)
        couponNumber?.isUserInteractionEnabled = false
        couponNumber?.titleLabel?.font = UIFont.systemFont(ofSize: 8)
        couponNumber?.isHidden = true
        addSubview(couponNumber!)
    }
    
    func setCouponNumer(number: Int) {
        if number > 0 && number <= 9 {
            couponNumber?.isHidden = false
            couponNumber?.setTitle("\(number)", for: .normal)
        } else if number > 9 && number < 100 {
            couponNumber?.setTitle("\(number)", for: .normal)
            couponNumber?.isHidden = false
        } else {
            couponNumber?.isHidden = true
        }
    }
}


class MineOrderView: UIView {
    
    var btn: MineUpImageDownText!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        btn = MineUpImageDownText(frame: CGRect.zero, title: "我的订单", imageName: "v2_my_order_icon")
        addSubview(btn)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        btn.frame = CGRect(x:10, y:10, width:width - 20, height:height - 20)
    }
}

class MineCouponView: UIView {
    
    var btn: UpImageDownTextButton!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        btn = MineUpImageDownText(frame: CGRect.zero, title: "优惠劵", imageName: "v2_my_coupon_icon")
        addSubview(btn)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        btn.frame = CGRect(x:10, y:10, width:width - 20, height:height - 20)
    }
    
}

class MineMessageView: UIView {
    var btn: UpImageDownTextButton!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        btn = MineUpImageDownText(frame: CGRect.zero, title: "我的消息", imageName: "v2_my_message_icon")
        addSubview(btn)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        btn.frame = CGRect(x:10, y:10, width:width - 20, height:height - 20)
    }
}

class MineUpImageDownText: UpImageDownTextButton {
    
    init(frame: CGRect, title: String, imageName: String) {
        super.init(frame: frame)
        setTitle(title, for: .normal)
        setTitleColor(UIColor.colorWithCustom(r: 80, g: 80, b: 80), for: .normal)
        setImage(UIImage(named: imageName), for: .normal)
        isUserInteractionEnabled = false
        titleLabel?.font = UIFont.systemFont(ofSize: 13)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
