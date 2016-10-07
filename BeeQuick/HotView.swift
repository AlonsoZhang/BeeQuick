//
//  HotView.swift
//  BeeQuick
//
//  Created by Alonso on 16/10/6.
//  Copyright © 2016年 Alonso. All rights reserved.
//

import UIKit

class HotView: UIView {

    private let iconH = (ScreenWidth - 20) * 0.25
    private let iconW: CGFloat = 80
    
    var hotButtonClick:((_ index: Int) -> Void)?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    convenience init(frame: CGRect, hotButtonClick: @escaping ((_ index: Int) -> Void)) {
        self.init(frame:frame)
        self.hotButtonClick = hotButtonClick
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: 模型的Set方法
    var headData: HeadData? {
        didSet {
            if (headData?.icons?.count)! > 0 {
                for _ in 0..<headData!.icons!.count {
                    
                }
            }
        }
    }
    
}
