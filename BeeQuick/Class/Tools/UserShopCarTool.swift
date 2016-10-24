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
    
    private var supermarketProducts = [Goods]()
    
    class var sharedUserShopCar: UserShopCarTool {
        return instance
    }
    
    func userShopCarProductsNumber() -> Int {
        return ShopCarRedDotView.sharedRedDotView.buyNumber
    }
    
    func isEmpty() -> Bool {
        return supermarketProducts.count == 0
    }
    
    func addSupermarkProductToShopCar(goods: Goods) {
        for everyGoods in supermarketProducts {
            if everyGoods.id == goods.id {
                return
            }
        }
        
        supermarketProducts.append(goods)
    }
    
    func getShopCarProducts() -> [Goods] {
        return supermarketProducts
    }
    
    func getShopCarProductsClassifNumber() -> Int {
        return supermarketProducts.count
    }
    
    func removeSupermarketProduct(goods: Goods) {
        for i in 0..<supermarketProducts.count {
            let everyGoods = supermarketProducts[i]
            if everyGoods.id == goods.id {
                supermarketProducts.remove(at: i)
                NotificationCenter.default.post(name: NSNotification.Name(rawValue: LFBShopCarDidRemoveProductNSNotification), object: nil, userInfo: nil)
                return
            }
        }
    }
    
    func getAllProductsPrice() -> String {
        var allPrice: Double = 0
        for goods in supermarketProducts {
            allPrice = allPrice + Double(goods.partner_price!)! * Double(goods.userBuyNumber)
        }
        
        return "\(allPrice)".cleanDecimalPointZear()
    }
}
