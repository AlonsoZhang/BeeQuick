//
//  SearchProducts.swift
//  BeeQuick
//
//  Created by Alonso on 16/10/24.
//  Copyright © 2016年 Alonso. All rights reserved.
//

import UIKit

class SearchProducts: NSObject, DictModelProtocol {
    var code: Int = -1
    var msg: String?
    var reqid: String?
    var data: [Goods]?
    
    class func loadSearchData(completion:((_ data: SearchProducts?, _ error: NSError?) -> Void)) {
        let path = Bundle.main.path(forResource: "促销", ofType: nil)
        let data = NSData(contentsOfFile: path!)
        if data != nil {
            let dict: NSDictionary = (try! JSONSerialization.jsonObject(with: data! as Data, options: .allowFragments)) as! NSDictionary
            let modelTool = DictModelManager.sharedManager
            let data = modelTool.objectWithDictionary(dict: dict, cls: SearchProducts.self) as? SearchProducts
            completion(data, nil)
        }
    }
    
    static func customClassMapping() -> [String : String]? {
        return ["data" : "\(Goods.self)"]
    }
}
