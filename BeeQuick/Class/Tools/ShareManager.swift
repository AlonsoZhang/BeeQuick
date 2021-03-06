//
//  ShareManager.swift
//  BeeQuick
//
//  Created by Alonso on 2016/10/30.
//  Copyright © 2016年 Alonso. All rights reserved.
//

import UIKit

class ShareManager: NSObject {
    
    static private let blogURLStr = "http://www.jianshu.com/users/5fe7513c7a57/latest_articles"
    static private let authorImage = UIImage(named: "author")
    static private let shareText = "小熊Swift全新开源作品,高仿爱鲜蜂,配有blog讲解思路,喜欢的同学star点起来"
    
    class func shareToShareType(shareType: ShareType, vc: UIViewController) {
        
        switch shareType {
            
        case .WeiXinMyFriend:
            UMSocialData.default().extConfig.wechatSessionData.url = blogURLStr
            UMSocialData.default().extConfig.wechatSessionData.title = "小熊Swift开源新作"
            
            
            let shareURL = UMSocialUrlResource(snsResourceType: UMSocialUrlResourceTypeImage, url: blogURLStr)
            
            UMSocialDataService.default().postSNS(withTypes: [UMShareToWechatSession], content: shareText, image: authorImage, location: nil, urlResource: shareURL, presentedController: nil) { (response) -> Void in
                if response?.responseCode.rawValue == UMSResponseCodeSuccess.rawValue {
                    showSuccessAlert()
                } else {
                    showErrorAlert()
                }
            }
            
            break
            
        case .WeiXinCircleOfFriends:
            
            UMSocialData.default().extConfig.wechatTimelineData.url = blogURLStr
            UMSocialData.default().extConfig.wechatTimelineData.title = "小熊Swift开源新作"
            let shareURL = UMSocialUrlResource(snsResourceType: UMSocialUrlResourceTypeImage, url: blogURLStr)
            UMSocialDataService.default().postSNS(withTypes: [UMShareToWechatTimeline], content: shareText, image: authorImage, location: nil, urlResource: shareURL, presentedController: nil, completion: { (response) -> Void in
                if response?.responseCode.rawValue == UMSResponseCodeSuccess.rawValue {
                    showSuccessAlert()
                } else {
                    showErrorAlert()
                }
            })
            
            break
            
        case .SinaWeiBo:
            
            UMSocialDataService.default().postSNS(withTypes: [UMShareToSina], content: shareText + "   下载地址" + "https://github.com/ZhongTaoTian", image: authorImage, location: nil, urlResource: nil, presentedController: vc, completion: { (response) -> Void in
                if response?.responseCode.rawValue == UMSResponseCodeSuccess.rawValue {
                    showSuccessAlert()
                } else {
                    showErrorAlert()
                }
            })
            break
            
        case .QQZone:
            
            UMSocialData.default().extConfig.qzoneData.url = blogURLStr
            UMSocialData.default().extConfig.qzoneData.title = "小熊Swift开源新作"
            let shareURL = UMSocialUrlResource(snsResourceType: UMSocialUrlResourceTypeImage, url: blogURLStr)
            
            UMSocialDataService.default().postSNS(withTypes: [UMShareToQzone], content: shareText, image: authorImage, location: nil, urlResource: shareURL, presentedController: nil, completion: { (response) -> Void in
                if response?.responseCode.rawValue == UMSResponseCodeSuccess.rawValue {
                    showSuccessAlert()
                } else {
                    showErrorAlert()
                }
            })
            
            
            break
        }
    }
    
    class func showSuccessAlert() {
        
        let alert = UIAlertView(title: "成功", message: "分享成功", delegate: nil, cancelButtonTitle: "知道了")
        alert.show()
    }
    
    class func showErrorAlert() {
        
        let alert = UIAlertView(title: "失败", message: "分享失败", delegate: nil, cancelButtonTitle: "知道了")
        alert.show()
        
    }
}
