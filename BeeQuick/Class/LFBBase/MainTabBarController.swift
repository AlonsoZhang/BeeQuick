//
//  MainViewController.swift
//  BeeQuick
//
//  Created by Alonso on 16/10/5.
//  Copyright © 2016年 Alonso. All rights reserved.
//

import UIKit

class MainTabBarController: RAMAnimatedTabBarController {

    private var fristLoadMainTabBarController: Bool = false

    override func viewDidLoad() {
        super.viewDidLoad()

        buildMainTabBarChildViewController()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        if fristLoadMainTabBarController == false {
            let containers1 = createViewContainers()
            createCustomIcons(containers: containers1)
            fristLoadMainTabBarController = true
        }
    }
    
    override func addChildViewController(_ childController: UIViewController) {
        super.addChildViewController(childController)
        
    }
    
    // MARK: 初始化tabbar
    private func buildMainTabBarChildViewController() {
        tabBarControllerAddChildViewController(childView: HomeViewController(), title: "首页", imageName: "v2_home", selectedImageName: "v2_home_r")
        tabBarControllerAddChildViewController(childView: SupermarketViewController(), title: "闪电超市", imageName: "v2_order", selectedImageName: "v2_order_r")
        tabBarControllerAddChildViewController(childView: ScheduleViewController(), title: "新鲜预定", imageName: "freshReservation", selectedImageName: "freshReservation_r")
        tabBarControllerAddChildViewController(childView: ShopCartViewController(), title: "购物车", imageName: "shopCart", selectedImageName: "shopCart")
        tabBarControllerAddChildViewController(childView: MineViewController(), title: "我的", imageName: "v2_my", selectedImageName: "v2_my_r")
    }
    
    private func tabBarControllerAddChildViewController(childView: UIViewController, title: String, imageName: String, selectedImageName: String) {
        let vcItem = RAMAnimatedTabBarItem(title: title, image: UIImage(named: imageName), selectedImage: UIImage(named: selectedImageName))
        vcItem.animation = RAMBounceAnimation()
        childView.tabBarItem = vcItem
        
        let navigationVC = BaseNavigationController(rootViewController:childView)
        navigationVC.navigationBar.backgroundColor = UIColor.red
        addChildViewController(navigationVC)
    }
}
