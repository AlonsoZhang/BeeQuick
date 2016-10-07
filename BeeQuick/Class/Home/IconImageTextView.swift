//
//  IconImageTextView.swift
//  BeeQuick
//
//  Created by Alonso on 2016/10/7.
//  Copyright © 2016年 Alonso. All rights reserved.
//

import UIKit

class IconImageTextView: UIView {

    private var imageView: UIImageView?
    private var textLabel: UILabel?
    private var placeholderImage: UIImage?
    var activitie: Activities? {
        didSet {
            textLabel?.text = activitie?.name
            imageView?.image = placeholderImage
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        imageView = UIImageView()
        imageView?.isUserInteractionEnabled = false
        addSubview(imageView!)
        
        textLabel = UILabel()
        textLabel!.textAlignment = NSTextAlignment.center
        textLabel!.font = UIFont.systemFont(ofSize: 12)
        textLabel!.textColor = UIColor.black
        textLabel?.isUserInteractionEnabled = false
        addSubview(textLabel!)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    convenience init(frame: CGRect, placeholderImage: UIImage) {
        self.init(frame: frame)
        self.placeholderImage = placeholderImage
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        imageView?.frame = CGRect(x:0, y:0, width:width, height:height - 20)
        textLabel?.frame = CGRect(x:0, y:height - 20, width:width, height:20)
    }
}
