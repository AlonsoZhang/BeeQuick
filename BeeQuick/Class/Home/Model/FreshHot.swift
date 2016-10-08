//
//  FreshHot.swift
//  BeeQuick
//
//  Created by Alonso on 2016/10/7.
//  Copyright © 2016年 Alonso. All rights reserved.
//

import UIKit

class FreshHot: NSObject, DictModelProtocol {
    
    var page: Int = -1
    var code: Int = -1
    var msg: String?
    var data: [Goods]?
    
    class func loadFreshHotData(completion:(_ data: FreshHot?, _ error: NSError?) -> Void) {
        let path = Bundle.main.path(forResource: "首页新鲜热卖", ofType: nil)
        let data = NSData(contentsOfFile: path!)
        if data != nil {
            let dict: NSDictionary = (try! JSONSerialization.jsonObject(with: data! as Data, options: .allowFragments)) as! NSDictionary
            let modelTool = DictModelManager.sharedManager
            let data = modelTool.objectWithDictionary(dict: dict, cls: FreshHot.self) as? FreshHot
            completion(data, nil)
        }
    }
    
    static func customClassMapping() -> [String : String]? {
        return ["data" : "\(Goods.self)"]
    }
}

class Goods: NSObject {
    /// 商品ID
    var id: String?
    /// 商品姓名
    var name: String?
    var brand_id: String?
    /// 超市价格
    var market_price: String?
    var cid: String?
    var category_id: String?
    /// 当前价格
    var partner_price: String?
    var brand_name: String?
    var pre_img: String?
    
    var pre_imgs: String?
    /// 参数
    var specifics: String?
    var product_id: String?
    var dealer_id: String?
    /// 当前价格
    var price: String?
    /// 库存
    var number: Int = -1
    /// 买一赠一
    var pm_desc: String?
    /// urlStr
    var img: String?
}