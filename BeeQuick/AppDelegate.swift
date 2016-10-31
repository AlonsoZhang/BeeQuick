//
//  AppDelegate.swift
//  BeeQuick
//
//  Created by Alonso on 16/10/4.
//  Copyright © 2016年 Alonso. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var window: UIWindow?
    var adViewController: ADViewController?
    
    // MARK:- public方法
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey : Any]? = nil) -> Bool {
        Thread.sleep(forTimeInterval: 1.0)
        
        //setUM()
        
        setAppSubject()
        
        addNotification()
        
        window = UIWindow(frame: ScreenBounds)
        window!.makeKeyAndVisible()
        
        loadKeyWindowRootViewController()
        
        return true
    }
    
    func applicationDidReceiveMemoryWarning(_ application: UIApplication) {}
    
//    func application(application: UIApplication, openURL url: URL, sourceApplication: String?, annotation: AnyObject) -> Bool {
//        
//        let result = UMSocialSnsService.handleOpenURL(url)
//        print(url)
//        if !result {
//            
//        }
//        
//        return true
//    }
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
    
    // MARK: - Public Method
    private func loadKeyWindowRootViewController() {
        
        let isFristOpen = UserDefaults.standard.object(forKey: "isFristOpenApp")
        
        if isFristOpen == nil {
            
            window?.rootViewController = GuideViewController()
            UserDefaults.standard.set("isFristOpenApp", forKey: "isFristOpenApp")
            
        } else {
            
            loadADRootViewController()
            
        }
    }
    
    func loadADRootViewController() {
        adViewController = ADViewController()
        
        weak var tmpSelf = self
        MainAD.loadADData { (data, error) -> Void in
            if data?.data?.img_name != nil {
                tmpSelf!.adViewController!.imageName = data!.data!.img_name
                tmpSelf!.window?.rootViewController = self.adViewController
            }
        }
    }
    
    func addNotification() {
        NotificationCenter.default.addObserver(self, selector: #selector(AppDelegate.showMainTabbarControllerSucess(noti:)), name: NSNotification.Name(rawValue: ADImageLoadSecussed), object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(AppDelegate.showMainTabbarControllerFale), name: NSNotification.Name(rawValue: ADImageLoadFail), object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(AppDelegate.shoMainTabBarController), name: NSNotification.Name(rawValue: GuideViewControllerDidFinish), object: nil)
    }
    
//    func setUM() {
//        UMSocialData.setAppKey("569f662be0f55a0efa0001cc")
//        UMSocialWechatHandler.setWXAppId("wxb81a61739edd3054", appSecret: "c62eba630d950ff107e62fe08391d19d", url: "https://github.com/ZhongTaoTian")
//        UMSocialQQHandler.setQQWithAppId("1105057589", appKey: "Zsc4rA9VaOjexv8z", url: "http://www.jianshu.com/users/5fe7513c7a57/latest_articles")
//        UMSocialSinaSSOHandler.openNewSinaSSOWithAppKey("1939108327", redirectURL: "http://sns.whalecloud.com/sina2/callback")
//        
//        UMSocialConfig.hiddenNotInstallPlatforms([UMShareToWechatSession, UMShareToQzone, UMShareToQQ, UMShareToSina, UMShareToWechatTimeline])
//    }
    
    // MARK: - Action
    func showMainTabbarControllerSucess(noti: NSNotification) {
        let adImage = noti.object as! UIImage
        let mainTabBar = MainTabBarController()
        mainTabBar.adImage = adImage
        window?.rootViewController = mainTabBar
    }
    
    func showMainTabbarControllerFale() {
        window!.rootViewController = MainTabBarController()
    }
    
    func shoMainTabBarController() {
        window!.rootViewController = MainTabBarController()
    }
    
    // MARK:- privete Method
    // MARK:主题设置
    private func setAppSubject() {
        let tabBarAppearance = UITabBar.appearance()
        tabBarAppearance.backgroundColor = UIColor.white
        tabBarAppearance.backgroundColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0)
        
        let navBarnAppearance = UINavigationBar.appearance()
        navBarnAppearance.isTranslucent = false
    }
}
