//
//  HomeViewController.swift
//  BeeQuick
//
//  Created by Alonso on 16/10/5.
//  Copyright © 2016年 Alonso. All rights reserved.
//

import UIKit

class HomeViewController: BaseViewController {

    var headView: HomeTableHeadView?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        buildNavigationItem()
        
        buildTableHeadView()
        
    }
    
// MARK:- Creat UI
    func buildNavigationItem() {
        navigationController?.navigationBar.barTintColor = LFBNavigationYellowColor
        
        navigationItem.leftBarButtonItem = UIBarButtonItem.barButton(title: "扫一扫", titleColor: UIColor.black,
                                                                     image: UIImage(named: "icon_black_scancode")!, hightLightImage: nil,
                                                                     target: self, action: #selector(HomeViewController.leftItemClick), type: ItemButtonType.Left)
        navigationItem.rightBarButtonItem = UIBarButtonItem.barButton(title: "搜 索", titleColor: UIColor.black,
                                                                      image: UIImage(named: "icon_search")!,hightLightImage: nil,
                                                                      target: self, action: #selector(HomeViewController.rightItemClick), type: ItemButtonType.Right)
    }
    
    func buildTableHeadView() {
        headView = HomeTableHeadView(frame: CGRect(x:0, y:0, width:ScreenWidth, height:150))
        headView?.delegate = self
        view.addSubview(headView!)
    }
    
    // MARK:- Action
    // MARK: 扫一扫和搜索Action
    func leftItemClick() {
        print("左")
    }
    
    func rightItemClick() {
        print("右")
    }
    
    // MARK: TableHeadViewAction
}

// MARK:- HomeHeadViewDelegate
extension HomeViewController: HomeTableHeadViewDelegate {
    func tableHeadView(headView: HomeTableHeadView, focusImageViewClick index: Int) {
        print(index)
    }
}
