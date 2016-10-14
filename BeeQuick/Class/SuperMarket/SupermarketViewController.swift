//
//  SupermarketViewController.swift
//  BeeQuick
//
//  Created by Alonso on 16/10/5.
//  Copyright © 2016年 Alonso. All rights reserved.
//

import UIKit

class SupermarketViewController: BaseViewController {

    fileprivate var supermarketData: Supermarket?
    fileprivate var categoryTableView: LFBTableView!
    fileprivate var productsVC: ProductsViewController!
    
    //MARK: Lazy Property
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        buildNavigationItem()
        
        bulidCategoryTableView()
        
        bulidProductsViewController()
        
        loadSupermarketData()
    }
    
    
    // MARK:- Creat UI
    private func buildNavigationItem() {
        navigationController?.navigationBar.barTintColor = LFBNavigationYellowColor
        
        navigationItem.leftBarButtonItem = UIBarButtonItem.barButton(title: "扫一扫", titleColor: UIColor.black,
                                                                     image: UIImage(named: "icon_black_scancode")!, hightLightImage: nil,
                                                                     target: self, action: #selector(SupermarketViewController.leftItemClick), type: ItemButtonType.Left)
        navigationItem.rightBarButtonItem = UIBarButtonItem.barButton(title: "搜 索", titleColor: UIColor.black,
                                                                      image: UIImage(named: "icon_search")!,hightLightImage: nil,
                                                                      target: self, action: #selector(SupermarketViewController.rightItemClick), type: ItemButtonType.Right)
    }
    
    private func bulidCategoryTableView() {
        categoryTableView = LFBTableView(frame: CGRect(x:0, y:0, width:ScreenWidth * 0.25, height:ScreenHeight), style: .plain)
        categoryTableView.backgroundColor = LFBGlobalBackgroundColor
        categoryTableView.delegate = self
        categoryTableView.dataSource = self
        categoryTableView.showsHorizontalScrollIndicator = false
        categoryTableView.showsVerticalScrollIndicator = false
        categoryTableView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: NavigationH, right: 0)
        view.addSubview(categoryTableView)
    }
    
    private func bulidProductsViewController() {
        productsVC = ProductsViewController()
        productsVC.delegate = self
        addChildViewController(productsVC)
        view.addSubview(productsVC.view)
        
        weak var tmpSelf = self
        productsVC.refreshUpPull = {
            Supermarket.loadSupermarketData { (data, error) -> Void in
                if error == nil {
                    let time = dispatch_time(DISPATCH_TIME_NOW,Int64(1.0 * Double(NSEC_PER_SEC)))
                    dispatch_after(time, dispatch_get_main_queue(), { () -> Void in
                        tmpSelf!.supermarketData = data
                        tmpSelf!.productsVC.supermarketData = data
                        tmpSelf?.productsVC.productsTableView?.mj_header.endRefreshing()
                        tmpSelf!.categoryTableView.reloadData()
                        tmpSelf!.categoryTableView.selectRowAtIndexPath(NSIndexPath(forRow: 0, inSection: 0), animated: true, scrollPosition: .Top)
                    })
                }
            }
        }
    }
    
    private func loadSupermarketData() {
        ProgressHUDManager.show()
        weak var tmpSelf = self
        Supermarket.loadSupermarketData { (data, error) -> Void in
            if error == nil {
                tmpSelf!.supermarketData = data
                tmpSelf!.categoryTableView.reloadData()
                tmpSelf?.categoryTableView.selectRow(at: IndexPath(row: 0, section: 0), animated: true, scrollPosition: .bottom)
                tmpSelf!.productsVC.supermarketData = data
            }
            
            let time = dispatch_time(DISPATCH_TIME_NOW,Int64(1.0 * Double(NSEC_PER_SEC)))
            dispatch_after(time, dispatch_get_main_queue(), { () -> Void in
                ProgressHUDManager.dismiss()
            })
        }
    }
    
    // MARK:- Action
    // MARK: 扫一扫和搜索Action
    func leftItemClick() {
        print("左")
    }
    
    func rightItemClick() {
        print("右")
    }
    
}

// MARK: - UITableViewDelegate, UITableViewDataSource
extension SupermarketViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return supermarketData?.data?.categories?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = CategoryCell.cellWithTableView(tableView: tableView)
        cell.categorie = supermarketData!.data!.categories![indexPath.row]
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        return 45
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if productsVC != nil {
            productsVC.categortsSelectedIndexPath = indexPath as NSIndexPath?
        }
    }
    
}

// MARK: - SupermarketViewController
extension SupermarketViewController: ProductsViewControllerDelegate {
    
    func didEndDisplayingHeaderView(section: Int) {
        categoryTableView.selectRow(at: IndexPath(row: section + 1, section: 0), animated: true, scrollPosition: UITableViewScrollPosition.middle)
    }
    
    func willDisplayHeaderView(section: Int) {
        categoryTableView.selectRow(at: IndexPath(row: section, section: 0), animated: true, scrollPosition: UITableViewScrollPosition.middle)
    }
}
