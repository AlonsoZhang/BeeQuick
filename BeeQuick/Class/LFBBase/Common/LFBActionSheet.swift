//
//  LFBActionSheet.swift
//  BeeQuick
//
//  Created by Alonso on 2016/10/30.
//  Copyright © 2016年 Alonso. All rights reserved.
//

import UIKit

enum ShareType: Int {
    case WeiXinMyFriend = 1
    case WeiXinCircleOfFriends = 2
    case SinaWeiBo = 3
    case QQZone = 4
}

class LFBActionSheet: NSObject, UIActionSheetDelegate {
    
    private var selectedShaerType: ((_ shareType: ShareType) -> ())?
    private var actionSheet: UIActionSheet?
    
    func showActionSheetViewShowInView(inView: UIView, selectedShaerType: @escaping ((_ shareType: ShareType) -> ())) {
        
        actionSheet = UIActionSheet(title: "分享到",
                                    delegate: self, cancelButtonTitle: "取消",
                                    destructiveButtonTitle: nil,
                                    otherButtonTitles: "微信好友", "微信朋友圈", "新浪微博", "QQ空间")
        
        self.selectedShaerType = selectedShaerType
        
        actionSheet?.show(in: inView)
        
    }
    
    func actionSheet(_ actionSheet: UIActionSheet, clickedButtonAt buttonIndex: Int) {
        print(buttonIndex)
        if selectedShaerType != nil {
            
            switch buttonIndex {
                
            case ShareType.WeiXinMyFriend.rawValue:
                selectedShaerType!(.WeiXinMyFriend)
                break
                
            case ShareType.WeiXinCircleOfFriends.rawValue:
                selectedShaerType!(.WeiXinCircleOfFriends)
                break
                
            case ShareType.SinaWeiBo.rawValue:
                selectedShaerType!(.SinaWeiBo)
                break
                
            case ShareType.QQZone.rawValue:
                selectedShaerType!(.QQZone)
                break
                
            default:
                break
            }
        }
    }
}
