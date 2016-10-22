//
//  ShopCartViewController.swift
//  BeeQuick
//
//  Created by Alonso on 16/10/5.
//  Copyright © 2016年 Alonso. All rights reserved.
//

import UIKit

class ShopCartViewController: BaseViewController {

    let userShopCar = UserShopCarTool.sharedUserShopCar
    
    private let shopImageView = UIImageView()
    private let emptyLabel = UILabel()
    private let emptyButton = UIButton(type: .custom)
    
    // MARK: - life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        buildNavigationItem()
        
        buildEmptyUI()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        if userShopCar.isEmpty() {
            showshopCarEmptyUI()
        }
    }
    
    
    // MARK: - Build UI
    private func buildNavigationItem() {
        navigationItem.title = "购物车"
        
        navigationItem.leftBarButtonItem = UIBarButtonItem.barButton(image: UIImage(named: "v2_goback")!, target: self, action: #selector(ShopCartViewController.leftNavigitonItemClick))
    }
    
    private func buildEmptyUI() {
        shopImageView.image = UIImage(named: "v2_shop_empty")
        shopImageView.contentMode = UIViewContentMode.center
        shopImageView.frame = CGRect(x:(view.width - shopImageView.width) * 0.5, y:view.height * 0.25, width:shopImageView.width, height:shopImageView.height)
        shopImageView.isHidden = true
        view.addSubview(shopImageView)
        
        emptyLabel.text = "亲,购物车空空的耶~赶紧挑好吃的吧"
        emptyLabel.textColor = UIColor.colorWithCustom(r: 100, g: 100, b: 100)
        emptyLabel.textAlignment = NSTextAlignment.center
        emptyLabel.frame = CGRect(x:0, y:shopImageView.frame.maxY + 55, width:view.width, height:50)
        emptyLabel.font = UIFont.systemFont(ofSize: 16)
        emptyLabel.isHidden = true
        view.addSubview(emptyLabel)
        
        emptyButton.frame = CGRect(x:(view.width - 150) * 0.5, y:emptyLabel.frame.maxY + 15, width:150, height:30)
        emptyButton.setBackgroundImage(UIImage(named: "btn.png"), for: UIControlState.normal)
        emptyButton.setTitle("去逛逛", for: UIControlState.normal)
        emptyButton.setTitleColor(UIColor.colorWithCustom(r: 100, g: 100, b: 100), for: UIControlState.normal)
        emptyButton.addTarget(self, action: #selector(ShopCartViewController.leftNavigitonItemClick), for: UIControlEvents.touchUpInside)
        emptyButton.isHidden = true
        view.addSubview(emptyButton)
    }
    // MARK: - Private Method
    private func showshopCarEmptyUI() {
        shopImageView.isHidden = false
        emptyButton.isHidden = false
        emptyLabel.isHidden = false
    }
    
    // MARK:-  Action
    func leftNavigitonItemClick() {
        dismiss(animated: true, completion: nil)
    }
    
    
}
