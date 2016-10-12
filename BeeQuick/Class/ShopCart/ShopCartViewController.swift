//
//  ShopCartViewController.swift
//  BeeQuick
//
//  Created by Alonso on 16/10/5.
//  Copyright © 2016年 Alonso. All rights reserved.
//

import UIKit

class ShopCartViewController: BaseViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        bulidNavigationItem()
    }
    
    private func bulidNavigationItem() {
        navigationItem.title = "购物车"
        
        navigationItem.leftBarButtonItem = UIBarButtonItem.barButton(UIImage(named: "v2_goback")!, target: self, action: "leftNavigitonItemClick")
    }
    
    // MARK:-  Action
    func leftNavigitonItemClick() {
        dismissViewControllerAnimated(true, completion: nil)
    }
}
