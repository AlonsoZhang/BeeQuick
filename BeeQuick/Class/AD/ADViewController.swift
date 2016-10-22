//
//  ADViewController.swift
//  BeeQuick
//
//  Created by Alonso on 16/10/17.
//  Copyright © 2016年 Alonso. All rights reserved.
//

import UIKit

class ADViewController: UIViewController {
    var isHidden:Bool = false
    private lazy var backImageView: UIImageView = {
        let backImageView = UIImageView()
        backImageView.frame = ScreenBounds
        return backImageView
    }()
    
    var imageName: String? {
        didSet {
            var placeholderImageName: String?
            switch UIDevice.currentDeviceScreenMeasurement() {
            case 3.5:
                placeholderImageName = "iphone4"
            case 4.0:
                placeholderImageName = "iphone5"
            case 4.7:
                placeholderImageName = "iphone6"
            default:
                placeholderImageName = "iphone6s"
            }
            backImageView.sd_setImage(with: NSURL(string: imageName!) as URL!, placeholderImage: UIImage(named: placeholderImageName!), options: SDWebImageOptions()) { (image, error, _, _) in
                if error != nil {
                    //加载广告失败
                    print("加载广告失败")
                    NotificationCenter.default.post(name: NSNotification.Name(rawValue: ADImageLoadFail), object: nil)
                }
                
                if image != nil {
                    DispatchQueue.main.asyncAfter(deadline: .now() + 1.0, execute: {
                        self.isHidden = false
                        self.setNeedsStatusBarAppearanceUpdate()
                        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5, execute: {
                            NotificationCenter.default.post(name: NSNotification.Name(rawValue: ADImageLoadSecussed), object: image)
                        })

                    })
                }
            }
        }
    }
    
    fileprivate func prefersStatusBarHidden() -> Bool {
        return isHidden
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.addSubview(backImageView)
        isHidden = true
        self.setNeedsStatusBarAppearanceUpdate()
    }
}
