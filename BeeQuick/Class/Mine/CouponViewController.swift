//
//  CouponViewController.swift
//  BeeQuick
//
//  Created by Alonso on 16/10/17.
//  Copyright © 2016年 Alonso. All rights reserved.
//

import UIKit

class CouponViewController: BaseViewController {

    private var bindingCouponView: BindingCouponView?
    private var couponTableView: LFBTableView?
    
    fileprivate var useCoupons: [Coupon] = [Coupon]()
    fileprivate var unUseCoupons: [Coupon] = [Coupon]()
    
    
    // MARK: life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = UIColor.white
        
        setNavigationItem()
        
        buildBindingCouponView()
        
        bulidCouponTableView()
        
        loadCouponData()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        navigationController?.setNavigationBarHidden(false, animated: animated)
    }
    
    // MARK: bulidUI
    private func setNavigationItem() {
        navigationItem.title = "优惠劵"
        
        navigationItem.rightBarButtonItem = UIBarButtonItem.barButton(title: "使用规则", titleColor: UIColor.colorWithCustom(r: 100, g: 100, b: 100), target: self, action: #selector(CouponViewController.rightItemClick))
    }
    
    func buildBindingCouponView() {
        bindingCouponView = BindingCouponView(frame: CGRect(x:0, y:0, width:ScreenWidth, height:50), bindingButtonClickBack: { (couponTextFiled) -> () in
            if couponTextFiled.text != nil && !(couponTextFiled.text!.isEmpty) {
                ProgressHUDManager.showImage(image: UIImage(named: "v2_orderSuccess")!, status: "请输入正确的优惠劵")
            } else {
                let alert = UIAlertController(title: nil, message: "请输入优惠码!", preferredStyle: UIAlertControllerStyle.alert)
                alert.addAction(UIAlertAction(title: "确定", style: UIAlertActionStyle.default, handler: nil))
                self.present(alert, animated: true, completion: nil)
            }
        })
        view.addSubview(bindingCouponView!)
    }
    
    private func bulidCouponTableView() {
        couponTableView = LFBTableView(frame: CGRect(x:0, y:bindingCouponView!.frame.maxY, width:ScreenWidth, height:ScreenHeight - bindingCouponView!.height - NavigationH), style: UITableViewStyle.plain)
        couponTableView!.delegate = self
        couponTableView?.dataSource = self
        view.addSubview(couponTableView!)
    }
    // MARK: Method
    private func loadCouponData() {
        weak var tmpSelf = self
        CouponData.loadCouponData { (data, error) -> Void in
            if error != nil {
                return
            }
            
            if (data?.data?.count != nil) {
                for obj in data!.data! {
                    switch obj.status {
                    case 0: tmpSelf!.useCoupons.append(obj)
                        break
                    default: tmpSelf!.unUseCoupons.append(obj)
                        break
                    }
                }
            }
            
            tmpSelf!.couponTableView?.reloadData()
        }
    }
    
    // MARK: Action
    func rightItemClick() {
        let couponRuleVC = CoupinRuleViewController()
        couponRuleVC.loadURLStr = CouponUserRuleURLString
        couponRuleVC.navTitle = "使用规则"
        navigationController?.pushViewController(couponRuleVC, animated: true)
    }
}

// - MARK: UITableViewDelegate, UITableViewDataSource
extension CouponViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if useCoupons.count > 0 && unUseCoupons.count > 0 {
            if 0 == section {
                return useCoupons.count
            } else {
                return unUseCoupons.count
            }
        }
        
        if useCoupons.count > 0 {
            return useCoupons.count
        }
        
        if unUseCoupons.count > 0 {
            return unUseCoupons.count
        }
        
        return 0
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        if useCoupons.count > 0 && unUseCoupons.count > 0 {
            return 2
        } else if useCoupons.count > 0 || unUseCoupons.count > 0 {
            return 1
        }
        
        return 0
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 130
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = CouponCell.cellWithTableView(tableView: tableView)
        var coupon: Coupon?
        if useCoupons.count > 0 && unUseCoupons.count > 0 {
            if 0 == indexPath.section {
                coupon = useCoupons[indexPath.row]
            } else {
                coupon = unUseCoupons[indexPath.row]
            }
        } else if useCoupons.count > 0 {
            coupon = useCoupons[indexPath.row]
        } else if unUseCoupons.count > 0 {
            coupon = unUseCoupons[indexPath.row]
        }
        
        cell.coupon = coupon!
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        if unUseCoupons.count > 0 && useCoupons.count > 0 && 0 == section {
            return 10
        }
        
        return 0
    }
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        if unUseCoupons.count > 0 && useCoupons.count > 0 {
            if 0 == section {
                let footView = UIView(frame: CGRect(x:0, y:0, width:ScreenWidth, height:10))
                footView.backgroundColor = UIColor.clear
                let lineView = UIView(frame: CGRect(x:CouponViewControllerMargin, y:4.5, width:ScreenWidth - 2 * CouponViewControllerMargin, height:1))
                lineView.backgroundColor = UIColor.colorWithCustom(r:230, g: 230, b: 230)
                footView.addSubview(lineView)
                return footView
            } else {
                return nil
            }
        } else {
            return nil
        }
    }
}
