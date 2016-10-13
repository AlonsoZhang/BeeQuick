//
//  HomeViewController.swift
//  BeeQuick
//
//  Created by Alonso on 16/10/5.
//  Copyright © 2016年 Alonso. All rights reserved.
//

import UIKit

class HomeViewController: BaseViewController {
    private var flag: Int = -1
    private var headView: HomeTableHeadView?
    private var collectionView: LFBCollectionView!
    fileprivate var lastContentOffsetY: CGFloat = 0
    fileprivate var isAnimation: Bool = false
    fileprivate var headData: HeadResources?
    fileprivate var freshHot: FreshHot?
    fileprivate var animationLayers: [CALayer]?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        addHomeNotification()
        
        buildNavigationItem()
        
        buildCollectionView()
        
        buildTableHeadView()
        
        buildProessHud()
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
    
    // MARK:- addNotifiation
    func addHomeNotification() {
        NotificationCenter.default.addObserver(self, selector: #selector(homeTableHeadViewHeightDidChange(noti:)), name: NSNotification.Name(rawValue: HomeTableHeadViewHeightDidChange), object: nil)
        NotificationCenter.default.addObserver(self, selector: Selector(("goodsInventoryProblem:")), name: NSNotification.Name(rawValue: HomeGoodsInventoryProblem), object: nil)
    }
    
    // MARK:- Creat UI
    private func buildNavigationItem() {
        navigationController?.navigationBar.barTintColor = LFBNavigationYellowColor
        
        navigationItem.leftBarButtonItem = UIBarButtonItem.barButton(title: "扫一扫", titleColor: UIColor.black,
                                                                     image: UIImage(named: "icon_black_scancode")!, hightLightImage: nil,
                                                                     target: self, action: #selector(HomeViewController.leftItemClick), type: ItemButtonType.Left)
        navigationItem.rightBarButtonItem = UIBarButtonItem.barButton(title: "搜 索", titleColor: UIColor.black,
                                                                      image: UIImage(named: "icon_search")!,hightLightImage: nil,
                                                                      target: self, action: #selector(HomeViewController.rightItemClick), type: ItemButtonType.Right)
    }
    
    private func buildTableHeadView() {
        headView = HomeTableHeadView()
        headView?.delegate = self
        weak var tmpSelf = self
        HeadResources.loadHomeHeadData { (data, error) -> Void in
            if error == nil {
                tmpSelf?.headView?.headData = data
                tmpSelf?.headData = data
                tmpSelf?.collectionView.reloadData()
            }
        }
        
        collectionView.addSubview(headView!)
        
        FreshHot.loadFreshHotData { (data, error) -> Void in
            tmpSelf?.freshHot = data
            tmpSelf?.collectionView.reloadData()
            tmpSelf?.collectionView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: 64, right: 0)
        }
    }
    
    private func buildCollectionView() {
        let layout = UICollectionViewFlowLayout()
        layout.minimumInteritemSpacing = 5
        layout.minimumLineSpacing = 8
        layout.sectionInset = UIEdgeInsets(top: 0, left: HomeCollectionViewCellMargin, bottom: 0, right: HomeCollectionViewCellMargin)
        layout.headerReferenceSize = CGSize(width:0, height:HomeCollectionViewCellMargin)
        
        collectionView = LFBCollectionView(frame: CGRect(x:0, y:0, width:ScreenWidth, height:ScreenHeight - 64), collectionViewLayout: layout)
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.backgroundColor = LFBGlobalBackgroundColor
        collectionView.register(HomeCell.self, forCellWithReuseIdentifier: "Cell")
        collectionView.register(HomeCollectionHeaderView.self, forSupplementaryViewOfKind: UICollectionElementKindSectionHeader, withReuseIdentifier: "headerView")
        collectionView.register(HomeCollectionFooterView.self, forSupplementaryViewOfKind: UICollectionElementKindSectionFooter, withReuseIdentifier: "footerView")
        view.addSubview(collectionView)
    }
    
    private func buildProessHud() {
        ProgressHUDManager.setBackgroundColor(color: UIColor.colorWithCustom(r: 240, g: 240, b: 240))
        ProgressHUDManager.setFont(font: UIFont.systemFont(ofSize: 16))
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
    
    func goodsInventoryProblem(noti: NSNotification) {
        if let goodsName = noti.object as? String {
            ProgressHUDManager.showImage(image: UIImage(named: "v2_orderSuccess")!, status: goodsName + "  库存不足了\n先买这么多, 过段时间再来看看吧~")
        }
    }
    
    // MARK: 商品添加到购物车动画
    fileprivate func addProductsAnimation(imageView: UIImageView) {
        if animationLayers == nil {
            animationLayers = [CALayer]()
        }
        
        let frame = imageView.convert(imageView.bounds, to: view)
        let transitionLayer = CALayer()
        transitionLayer.frame = frame
        transitionLayer.contents = imageView.layer.contents
        transitionLayer.fillMode = kCAFillModeRemoved
        
        let p1 = transitionLayer.position
        let p3X = ScreenWidth - ScreenWidth / 5 - 10
        let p3 = CGPoint(x:p3X, y:view.layer.bounds.size.height - 20)
        
        let positionAnimation = CAKeyframeAnimation(keyPath: "position")
        let path = CGMutablePath()
        path.move(to: CGPoint(x:p1.x, y:p1.y))
        path.addLine(to: CGPoint(x:p3.x, y:p3.y))
        positionAnimation.isRemovedOnCompletion = true
        positionAnimation.path = path
        positionAnimation.fillMode = kCAFillModeForwards
        
        let transformAnimation =  CABasicAnimation(keyPath: "transform")
        transformAnimation.fromValue = NSValue(caTransform3D: CATransform3DIdentity)
        transformAnimation.toValue = NSValue(caTransform3D: CATransform3DScale(CATransform3DIdentity, 0.1, 0.1, 1))
        transformAnimation.fillMode = kCAFillModeForwards
        transformAnimation.isRemovedOnCompletion = true
        
        let opacityAnimation = CABasicAnimation(keyPath: "opacity")
        opacityAnimation.fromValue = 0.8
        opacityAnimation.toValue = 0.1
        opacityAnimation.fillMode = kCAFillModeForwards
        opacityAnimation.isRemovedOnCompletion = true
        
        let groupAnimation = CAAnimationGroup()
        groupAnimation.animations = [positionAnimation, transformAnimation, opacityAnimation];
        groupAnimation.duration = 0.5
        //groupAnimation.delegate = self

        transitionLayer.add(groupAnimation, forKey: "cartParabola")
        
        view.layer.addSublayer(transitionLayer)
        animationLayers!.append(transitionLayer)
        
//        let time = DispatchTime.now(dispatch_time_t(DispatchTime.now),Int64(0.4 * Double(NSEC_PER_SEC)))
//        dispatch_after(time, dispatch_get_main_queue()) { () -> Void in
//            transitionLayer.hidden = true
//        }
    }

//    override func animationDidStop(anim: CAAnimation, finished flag: Bool) {
//        if animationLayers!.count > 0 {
//            let transitionLayer = animationLayers![0]
//            transitionLayer.isHidden = true
//            transitionLayer.removeFromSuperlayer()
//            animationLayers?.removeFirst()
//            view.layer.removeAnimation(forKey: "cartParabola")
//        }
//    }
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
            return headData?.data?.activities?.count ?? 0
        } else if section == 1 {
            return freshHot?.data?.count ?? 0
        }
        
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Cell", for: indexPath as IndexPath)as! HomeCell
        
        if indexPath.section == 0 {
            cell.activities = headData!.data!.activities![indexPath.row]
        } else if indexPath.section == 1 {
            cell.goods = freshHot!.data![indexPath.row]
            weak var tmpSelf = self
            cell.addButtonClick = ({ (imageView) -> () in
                tmpSelf?.addProductsAnimation(imageView: imageView)
            })
        }
        
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
            return CGSize(width:ScreenWidth, height:HomeCollectionViewCellMargin * 5)
        }
        
        return CGSize.zero
    }
    
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        if isAnimation {
            //Animation
            startAnimation(view: cell, offsetY: 80, duration: 1.0)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, willDisplaySupplementaryView view: UICollectionReusableView, forElementKind elementKind: String, at indexPath: IndexPath) {
        if indexPath.section == 1 && headData != nil && freshHot != nil && isAnimation {
            startAnimation(view: view, offsetY: 40, duration: 0.6)
        }
    }
    
    private func startAnimation(view: UIView, offsetY: CGFloat, duration: TimeInterval) {
        view.transform = CGAffineTransform(translationX: 0, y: offsetY)
        UIView.animate(withDuration: duration, animations: { () -> Void in
            view.transform = CGAffineTransform.identity
        })
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        if indexPath.section == 1 && kind == UICollectionElementKindSectionHeader {
            let headView = collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionElementKindSectionHeader, withReuseIdentifier: "headerView", for: indexPath as IndexPath) as! HomeCollectionHeaderView
            
            return headView
        }
        
        let footerView = collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionElementKindSectionFooter, withReuseIdentifier: "footerView", for: indexPath as IndexPath) as! HomeCollectionFooterView
        
        if indexPath.section == 1 && kind == UICollectionElementKindSectionFooter {
            footerView.showLabel()
            footerView.tag = 100
        } else {
            footerView.hideLabel()
            footerView.tag = 1
        }
        let tap = UITapGestureRecognizer(target: self, action: Selector(("moreGoodsClick:")))
        footerView.addGestureRecognizer(tap)
        
        return footerView
    }
    
    // MARK: 查看更多商品被点击
    func moreGoodsClick(tap: UITapGestureRecognizer) {
        if tap.view?.tag == 100 {
            let tabBarController = UIApplication.shared.keyWindow?.rootViewController as! MainTabBarController
            tabBarController.setSelectIndex(from: 0, to: 1)
        }
    }
    
    // MARK: - ScrollViewDelegate
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        print(animationLayers)
        if (animationLayers?.count)! > 0 {
            let transitionLayer = animationLayers![0]
            transitionLayer.isHidden = true
        }
        
        if scrollView.contentOffset.y <= scrollView.contentSize.height {
            isAnimation = lastContentOffsetY < scrollView.contentOffset.y
            lastContentOffsetY = scrollView.contentOffset.y
        }
    }
}
