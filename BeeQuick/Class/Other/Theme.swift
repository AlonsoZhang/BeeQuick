//
//  Theme.swift
//  BeeQuick
//
//  Created by Alonso on 16/10/5.
//  Copyright © 2016年 Alonso. All rights reserved.
//

import UIKit

// MARK: - 全局常用属性
public let NavigationH: CGFloat = 64
public let ScreenWidth: CGFloat = UIScreen.main.bounds.size.width
public let ScreenHeight: CGFloat = UIScreen.main.bounds.size.height
public let ScreenBounds: CGRect = UIScreen.main.bounds
public let LFBGlobalBackgroundColor = UIColor.colorWithCustom(r: 239, g: 239, b: 239)
public let LFBNavigationYellowColor = UIColor.colorWithCustom(r: 253, g: 212, b: 49)
public let LFBTextGreyColol = UIColor.colorWithCustom(r: 130, g: 130, b: 130)
public let ShopCarRedDotAnimationDuration: NSTimeInterval = 0.2

// MARK: - Home 属性
public let HotViewMargin: CGFloat = 10
public let HomeCollectionViewCellMargin: CGFloat = 10
public let HomeCollectionTextFont = UIFont.systemFont(ofSize: 14)
public let HomeCollectionCellAnimationDuration: NSTimeInterval = 1.0

// MARK: - 通知
/// 首页headView高度改变
public let HomeTableHeadViewHeightDidChange = "HomeTableHeadViewHeightDidChange"
/// 首页商品库存不足
public let HomeGoodsInventoryProblem = "HomeGoodsInventoryProblem"
