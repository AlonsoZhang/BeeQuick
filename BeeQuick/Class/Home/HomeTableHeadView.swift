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
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        buildPageScrollView()
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func buildPageScrollView() {
        pageScrollView = PageScrollView(frame: CGRect(x:0, y:0, width:ScreenWidth, height:150), placeholder: UIImage(named: "guide_40_3")!)
        pageScrollView?.imageURLSting = ["aa", "bb", "cc", "dd", "rr"]
        addSubview(pageScrollView!)
    }
}
