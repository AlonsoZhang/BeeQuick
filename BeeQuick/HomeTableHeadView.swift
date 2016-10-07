//
//  HomeTableHeadView.swift
//  BeeQuick
//
//  Created by Alonso on 16/10/6.
//  Copyright © 2016年 Alonso. All rights reserved.
//

import UIKit

class HomeTableHeadView: UIView {

    private var pageScrollView: PageScrollView?
    private var hotView: HotView?
    weak var delegate: HomeTableHeadViewDelegate?

    override init(frame: CGRect) {
        super.init(frame: frame)
        
        buildPageScrollView()
        buildHotView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: 模型的set方法
    var headData: HeadResources? {
        didSet {
            
            hotView!.headData = headData?.data
        }
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        pageScrollView?.frame = CGRect(x:0, y:0, width:ScreenWidth, height:ScreenWidth * 0.38)
    }
    
    func buildPageScrollView() {
        weak var tmpSelf = self
        pageScrollView = PageScrollView(frame: CGRect.zero, placeholder: UIImage(named: "v2_placeholder_full_size")!, focusImageViewClick: { (index) -> Void in
            if tmpSelf!.delegate != nil && ((tmpSelf!.delegate?.responds(to: Selector(("tableHeadView:focusImageViewClick:")))) != nil) {
                tmpSelf?.delegate?.tableHeadView!(headView: tmpSelf!, focusImageViewClick: index)
            }
        })
        pageScrollView?.imageURLSting = ["aa", "bb", "cc", "dd", "rr"]
        addSubview(pageScrollView!)
    }
    
    func buildHotView() {
        weak var tmpSelf = self
        hotView = HotView(frame: CGRect.zero, hotButtonClick: { (index) -> Void in
            if tmpSelf!.delegate != nil && ((tmpSelf!.delegate?.responds(to: Selector(("tableHeadView:hotButtonClick:")))) != nil) {
                tmpSelf?.delegate?.tableHeadView!(headView: tmpSelf!, focusImageViewClick: index)
            }
        })
        addSubview(hotView!)
    }
}

// - MARK: Delegate
@objc protocol HomeTableHeadViewDelegate: NSObjectProtocol {
    @objc optional func tableHeadView(headView: HomeTableHeadView, focusImageViewClick index: Int)
    @objc optional func tableHeadView(headView: HomeTableHeadView, hotButtonClick index: Int)
}
