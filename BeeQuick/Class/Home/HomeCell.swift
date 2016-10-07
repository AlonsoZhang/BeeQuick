//
//  HomeCell.swift
//  BeeQuick
//
//  Created by Alonso on 2016/10/7.
//  Copyright © 2016年 Alonso. All rights reserved.
//

import UIKit

class HomeCell: UICollectionViewCell {
    
    var backImageView: UIImageView?
    var goodsImageView: UIImageView?
    var name: UILabel?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        print("cccc")
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
