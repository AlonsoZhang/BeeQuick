//
//  UserMessage.swift
//  BeeQuick
//
//  Created by Alonso on 2016/10/23.
//  Copyright © 2016年 Alonso. All rights reserved.
//

import UIKit

enum UserMessageType: Int {
    case System = 0
    case User = 1
}

class UserMessage: NSObject {
    
    var id: String?
    var type = -1
    var title: String?
    var content: String?
    var link: String?
    var city: String?
    var noticy: String?
    var send_time: String?
    
    // 辅助参数
    var subTitleViewHeightNomarl: CGFloat = 60
    var cellHeight: CGFloat = 60 + 60 + 20
    var subTitleViewHeightSpread: CGFloat = 0
    
    class func loadSystemMessage(complete: ((_ data: [UserMessage]?, _ error: NSError?) -> ())) {
        
        complete(loadMessage(type: .System)!, nil)
    }
    
    class func loadUserMessage(complete: ((_ data: [UserMessage]?, _ error: NSError?) -> ())) {
        complete(loadMessage(type: .User), nil)
    }
    
    private class func userMessage(dict: NSDictionary) -> UserMessage {
        
        let modelTool = DictModelManager.sharedManager
        let message = modelTool.objectWithDictionary(dict: dict, cls: UserMessage.self) as? UserMessage
        
        return message!
    }
    
    private class func loadMessage(type: UserMessageType) -> [UserMessage]? {
        var data: [UserMessage]? = []
        
        let path = Bundle.main.path(forResource: ((type == .System) ? "SystemMessage" : "UserMessage"), ofType: nil)
        let resData = NSData(contentsOfFile: path!)
        if resData != nil {
            let dict: NSDictionary = (try! JSONSerialization.jsonObject(with: resData! as Data, options: .allowFragments)) as! NSDictionary
            if let array = dict.object(forKey: "data") as? NSArray {
                for dict in array {
                    let message = UserMessage.userMessage(dict: dict as! NSDictionary)
                    data?.append(message)
                }
            }
        }
        return data
    }
}
