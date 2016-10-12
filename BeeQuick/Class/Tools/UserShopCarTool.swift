//
//  UserShopCarTool.swift
//  BeeQuick
//
//  Created by Alonso on 16/10/12.
//  Copyright © 2016年 Alonso. All rights reserved.
//  记录用户购物车商品

import UIKit

class UserShopCarTool: NSObject {
    
    private static let instance = UserShopCarTool()
    
    class var sharedUserShopCar: UserShopCarTool {
        return instance
    }
    
}
