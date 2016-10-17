//
//  ADViewController.swift
//  BeeQuick
//
//  Created by Alonso on 16/10/17.
//  Copyright © 2016年 Alonso. All rights reserved.
//

import UIKit

class ADViewController: UIViewController {

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
            
            backImageView.sd_setImage(with: NSURL(string: imageName!) as URL!, placeholderImage: UIImage(named: placeholderImageName!)){ (image, error, _, _) -> Void in
                if error != nil {
                    //加载广告失败
                    print("加载广告失败")
                    NSNotificationCenter.defaultCenter().postNotificationName(ADImageLoadFail, object: nil)
                }
                
                if image != nil {
                    DispatchQueue.main.asyncAfter(deadline: .now() + 1.0, execute: {
                        UIApplication.sharedApplication().setStatusBarHidden(false, withAnimation: UIStatusBarAnimation.Fade)
                        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5, execute: {
                            NSNotificationCenter.defaultCenter().postNotificationName(ADImageLoadSecussed, object: image)
                        })

                    })
                }
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.addSubview(backImageView)
        UIApplication.shared.setStatusBarHidden(true, with: UIStatusBarAnimation.none)
    }
}
