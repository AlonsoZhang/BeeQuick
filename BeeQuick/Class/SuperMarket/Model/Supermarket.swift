//
//  Supermarket.swift
//  BeeQuick
//
//  Created by Alonso on 16/10/10.
//  Copyright © 2016年 Alonso. All rights reserved.
//

import UIKit

class Supermarket: NSObject, DictModelProtocol {
    var code: Int = -1
    var msg: String?
    var reqid: String?
    var data: SupermarketResouce?
    
    class func loadSupermarketData(completion:(_ data: Supermarket?, _ error: NSError?) -> Void) {
        let path = Bundle.main.path(forResource: "supermarket", ofType: nil)
        let data = NSData(contentsOfFile: path!)
        
        if data != nil {
            let dict: NSDictionary = (try! JSONSerialization.jsonObject(with: data! as Data, options: .allowFragments)) as! NSDictionary
            let modelTool = DictModelManager.sharedManager
            let data = modelTool.objectWithDictionary(dict: dict, cls: Supermarket.self) as? Supermarket
            completion(data, nil)
        }
    }
    
    static func customClassMapping() -> [String : String]? {
        return ["data" : "\(SupermarketResouce.self)"]
    }
}

class SupermarketResouce: NSObject {
    var categories: [Categorie]?
    var products: Products?
    var trackid: String?
    
    static func customClassMapping() -> [String : String]? {
        return ["categories" : "\(Categorie.self)", "products" : "\(Products.self)"]
    }
}

class Categorie: NSObject {
    var id: String?
    var name: String?
    var sort: String?
}

class Products: NSObject {
    
}
