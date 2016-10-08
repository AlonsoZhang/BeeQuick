//
//  ProgressHUDManager.swift
//  BeeQuick
//
//  Created by Alonso on 16/10/8.
//  Copyright © 2016年 Alonso. All rights reserved.
//

import UIKit


class ProgressHUDManager {
    
    class func setBackgroundColor(color: UIColor) {
        SVProgressHUD.setBackgroundColor(color)
    }
    
    class func setForegroundColor(color: UIColor) {
        SVProgressHUD.setForegroundColor(color)
    }
    
    class func setSuccessImage(image: UIImage) {
        SVProgressHUD.setSuccessImage(image)
    }
    
    class func setErrorImage(image: UIImage) {
        SVProgressHUD.setErrorImage(image)
    }
    
    class func setFont(font: UIFont) {
        SVProgressHUD.setFont(UIFont.systemFont(ofSize: 16))
    }
    
    class func showImage(image: UIImage, status: String) {
        SVProgressHUD.show(image, status: status)
    }
    
}
