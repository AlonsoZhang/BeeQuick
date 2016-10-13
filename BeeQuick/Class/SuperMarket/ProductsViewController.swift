//
//  ProductsViewController.swift
//  BeeQuick
//
//  Created by Alonso on 16/10/12.
//  Copyright © 2016年 Alonso. All rights reserved.
//

import UIKit

class ProductsViewController: BaseViewController {

    fileprivate let headViewIdentifier = "supermarketHeadView"
    fileprivate var lastOffsetY: CGFloat = 0
    fileprivate var isScrollDown = false
    
    var productsTableView: LFBTableView?
    weak var delegate: ProductsViewControllerDelegate?
    
    fileprivate var goodsArr: [[Goods]]? {
        didSet {
            productsTableView?.reloadData()
        }
    }
    
    var supermarketData: Supermarket? {
        didSet {
            self.goodsArr = Supermarket.searchCategoryMatchProducts(supermarketResouce: supermarketData!.data!)
        }
    }
    
    var categortsSelectedIndexPath: NSIndexPath? {
        didSet {
            productsTableView?.selectRow(at: IndexPath(row: 0, section: categortsSelectedIndexPath!.row), animated: true, scrollPosition: .top)
        }
    }
    
    override func viewDidLoad() {
        view = buildProductsTableView()
    }
    
    // MARK: - Build UI
    private func buildProductsTableView() -> UITableView{
        productsTableView = LFBTableView(frame: CGRect(x:ScreenWidth * 0.25, y:0, width:ScreenWidth * 0.75, height:ScreenHeight - NavigationH - 49), style: .plain)
        productsTableView?.backgroundColor = LFBGlobalBackgroundColor
        productsTableView?.delegate = self
        productsTableView?.dataSource = self
        productsTableView?.register(SupermarketHeadView.self, forHeaderFooterViewReuseIdentifier: headViewIdentifier)
        productsTableView?.tableFooterView = buildProductsTableViewTableFooterView()
        
        return productsTableView!
    }
    
    private func buildProductsTableViewTableFooterView() -> UIView {
        let imageView = UIImageView(frame: CGRect(x:0, y:0, width:productsTableView!.width, height:70))
        imageView.contentMode = UIViewContentMode.center
        imageView.image = UIImage(named: "v2_common_footer")
        return imageView
    }
}

// MARK: UITableViewDelegate, UITableViewDataSource
extension ProductsViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if (goodsArr?.count)! > 0 {
            return goodsArr![section].count ?? 0
        }
        
        return 0
    }
    
    private func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return supermarketData?.data?.categories?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = ProductCell()
        let goods = goodsArr![indexPath.section][indexPath.row]
        cell.goods = goods
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 85
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 25
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headView = tableView.dequeueReusableHeaderFooterView(withIdentifier: headViewIdentifier) as! SupermarketHeadView
        if (supermarketData?.data?.categories?.count)! > 0 && supermarketData!.data!.categories![section].name != nil {
            headView.titleLabel.text = supermarketData!.data!.categories![section].name
        }
        
        return headView
    }
    
    func tableView(_ tableView: UITableView, didEndDisplayingHeaderView view: UIView, forSection section: Int) {
        
        if delegate != nil && delegate!.responds(to: Selector(("didEndDisplayingHeaderView:"))) && isScrollDown {
            delegate!.didEndDisplayingHeaderView!(section: section)
        }
    }
    
    private func tableView(tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int) {
        if delegate != nil && delegate!.responds(to: Selector(("willDisplayHeaderView:"))) && !isScrollDown {
            delegate!.willDisplayHeaderView!(section: section)
        }
    }
}

// MARK: - UIScrollViewDelegate
extension ProductsViewController: UIScrollViewDelegate {
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        isScrollDown = lastOffsetY < scrollView.contentOffset.y
        lastOffsetY = scrollView.contentOffset.y
    }
}

@objc protocol ProductsViewControllerDelegate: NSObjectProtocol {
    @objc optional func didEndDisplayingHeaderView(section: Int)
    @objc optional func willDisplayHeaderView(section: Int)
}
