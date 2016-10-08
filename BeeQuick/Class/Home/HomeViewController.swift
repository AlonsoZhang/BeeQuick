//
//  HomeViewController.swift
//  BeeQuick
//
//  Created by Alonso on 16/10/5.
//  Copyright © 2016年 Alonso. All rights reserved.
//

import UIKit

class HomeViewController: BaseViewController {
    var flag: Int = -1
    var headView: HomeTableHeadView?
    var collectionView: UICollectionView!
    var lastContentOffsetY: CGFloat = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        addHomeNotification()
        
        buildNavigationItem()
        
        buildCollectionView()
        
        buildTableHeadView()
        
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
    
    // MARK:- addNotifiation
    func addHomeNotification() {
        NotificationCenter.default.addObserver(self, selector: #selector(homeTableHeadViewHeightDidChange(noti:)), name: NSNotification.Name(rawValue: HomeTableHeadViewHeightDidChange), object: nil)
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
        headView = HomeTableHeadView()
        headView?.delegate = self
        weak var tmpSelf = self
        HeadResources.loadHomeHeadData { (data, error) -> Void in
            if error == nil {
                tmpSelf?.headView?.headData = data
            }
        }
        
        collectionView.addSubview(headView!)
    }
    
    func buildCollectionView() {
        let layout = UICollectionViewFlowLayout()
        layout.minimumInteritemSpacing = 5
        layout.minimumLineSpacing = 8
        layout.sectionInset = UIEdgeInsets(top: 0, left: HomeCollectionViewCellMargin, bottom: 0, right: HomeCollectionViewCellMargin)
        layout.headerReferenceSize = CGSize(width:0, height:HomeCollectionViewCellMargin)
        
        collectionView = UICollectionView(frame: CGRect(x:0, y:0, width:ScreenWidth, height:ScreenHeight - NavigationH), collectionViewLayout: layout)
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(HomeCell.self, forCellWithReuseIdentifier: "Cell")
        view.addSubview(collectionView)
    }
    
    // MARK:- Action
    // MARK: 扫一扫和搜索Action
    func leftItemClick() {
        print("左")
    }
    
    func rightItemClick() {
        print("右")
    }
    
    // MARK: Notifiation Action
    func homeTableHeadViewHeightDidChange(noti: NSNotification) {
        collectionView!.contentInset = UIEdgeInsetsMake(noti.object as! CGFloat, 0, NavigationH, 0)
        collectionView!.setContentOffset(CGPoint(x: 0, y: -(collectionView!.contentInset.top)), animated: false)
        lastContentOffsetY = collectionView.contentOffset.y
    }
}

// MARK:- HomeHeadViewDelegate TableHeadViewAction
extension HomeViewController: HomeTableHeadViewDelegate {
    func tableHeadView(headView: HomeTableHeadView, focusImageViewClick index: Int) {
        print(index)
    }
    
    func tableHeadView(headView: HomeTableHeadView, iconClick index: Int) {
        print(index)
    }
}

// MARK:- UICollectionViewDelegate UICollectionViewDataSource
extension HomeViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if section == 0 {
            return 6
        } else if section == 1 {
            return 20
        }
        
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Cell", for: indexPath as IndexPath)
        
        cell.contentView.backgroundColor = UIColor.randomColor()
        return cell
    }
    
    private func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        return 2
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        var itemSize = CGSize.zero
        if indexPath.section == 0 {
            itemSize = CGSize(width:ScreenWidth - HomeCollectionViewCellMargin * 2, height:140)
        } else if indexPath.section == 1 {
            itemSize = CGSize(width:(ScreenWidth - HomeCollectionViewCellMargin * 2) * 0.5 - 4, height:250)
        }
        
        return itemSize
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        if section == 0 {
            return CGSize(width:ScreenWidth, height:HomeCollectionViewCellMargin)
        } else if section == 1 {
            return CGSize(width:ScreenWidth, height:HomeCollectionViewCellMargin * 2)
        }
        
        return CGSize.zero
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForFooterInSection section: Int) -> CGSize {
        if section == 0 {
            return CGSize(width:ScreenWidth, height:HomeCollectionViewCellMargin)
        } else if section == 1 {
            return CGSize(width:ScreenWidth, height:HomeCollectionViewCellMargin * 8)
        }
        
        return CGSize.zero
    }
    
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        if lastContentOffsetY <= collectionView.contentOffset.y {
            
            //Animation
            
            lastContentOffsetY = collectionView.contentOffset.y
        }
    }
}
