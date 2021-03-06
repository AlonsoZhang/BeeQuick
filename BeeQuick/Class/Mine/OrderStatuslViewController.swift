//
//  OrderStatuslViewController.swift
//  BeeQuick
//
//  Created by Alonso on 2016/10/23.
//  Copyright © 2016年 Alonso. All rights reserved.
//

import UIKit

class OrderStatuslViewController: BaseViewController {
    
    private var orderDetailTableView: LFBTableView?
    private var segment: LFBSegmentedControl!
    private var orderDetailVC: OrderDetailViewController?
    fileprivate var orderStatuses: [OrderStatus]? {
        didSet {
            orderDetailTableView?.reloadData()
        }
    }
    
    var order: Order? {
        didSet {
            orderStatuses = order?.status_timeline
            
            if order?.detail_buttons?.count != 0 {
                let btnWidth: CGFloat = 80
                let btnHeight: CGFloat = 30
                for i in 0..<order!.detail_buttons!.count {
                    let btn = UIButton(frame: CGRect(x:view.width - (10 + CGFloat(i + 1) * (btnWidth + 10)), y:view.height - 50 - NavigationH + (50 - btnHeight) * 0.5, width:btnWidth, height:btnHeight))
                    btn.setTitle(order!.detail_buttons![i].text, for: UIControlState.normal)
                    btn.backgroundColor = LFBNavigationYellowColor
                    btn.setTitleColor(UIColor.black, for: .normal)
                    btn.titleLabel?.font = UIFont.systemFont(ofSize: 13)
                    btn.layer.cornerRadius = 5;
                    btn.tag = order!.detail_buttons![i].type
                    btn.addTarget(self, action: #selector(OrderStatuslViewController.detailButtonClick(sender:)), for: UIControlEvents.touchUpInside)
                    view.addSubview(btn)
                }
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        buildNavigationItem()
        
        buildOrderDetailTableView()
        
        buildDetailButtonsView()
    }
    
    private func buildNavigationItem() {
        let rightItem = UIBarButtonItem.barButton(title: "投诉", titleColor: LFBTextBlackColor, target: self, action: #selector(OrderStatuslViewController.rightItemButtonClick))
        navigationItem.rightBarButtonItem = rightItem
        weak var tmpSelf = self
        segment = LFBSegmentedControl(items: ["订单状态" as AnyObject, "订单详情" as AnyObject], didSelectedIndex: { (index) -> () in
            if index == 0 {
                tmpSelf!.showOrderStatusView()
            } else if index == 1 {
                tmpSelf!.showOrderDetailView()
            }
        })
        navigationItem.titleView = segment
        navigationItem.titleView?.frame = CGRect(x:0, y:5, width:180, height:27)
    }
    
    private func buildOrderDetailTableView() {
        orderDetailTableView = LFBTableView(frame: CGRect(x:0, y:0, width:ScreenWidth, height:ScreenHeight - NavigationH), style: .plain)
        orderDetailTableView?.backgroundColor = UIColor.white
        orderDetailTableView?.delegate = self
        orderDetailTableView?.dataSource = self
        orderDetailTableView?.rowHeight = 80
        view.addSubview(orderDetailTableView!)
    }
    
    private func buildDetailButtonsView() {
        let bottomView = UIView(frame: CGRect(x:0, y:view.height - 50 - NavigationH, width:view.width, height:1))
        bottomView.backgroundColor = UIColor.gray
        bottomView.alpha = 0.1
        view.addSubview(bottomView)
        
        let bottomView1 = UIView(frame: CGRect(x:0, y:view.height - 49 - NavigationH, width:view.width, height:49))
        bottomView1.backgroundColor = UIColor.white
        view.addSubview(bottomView1)
    }
    
    // MARK: - Action
    func rightItemButtonClick() {
        
    }
    
    func detailButtonClick(sender: UIButton) {
        print("点击了底部按钮 类型是" + "\(sender.tag)")
    }
    
    func showOrderStatusView() {
        weak var tmpSelf = self
        tmpSelf!.orderDetailVC?.view.isHidden = true
        tmpSelf!.orderDetailTableView?.isHidden = false
    }
    
    func showOrderDetailView() {
        weak var tmpSelf = self
        if tmpSelf!.orderDetailVC == nil {
            tmpSelf!.orderDetailVC = OrderDetailViewController()
            tmpSelf!.orderDetailVC?.view.isHidden = false
            tmpSelf!.orderDetailVC?.order = order
            tmpSelf!.addChildViewController(orderDetailVC!)
            tmpSelf!.view.insertSubview(orderDetailVC!.view, at: 0)
        } else {
            tmpSelf!.orderDetailVC?.view.isHidden = false
        }
        tmpSelf!.orderDetailTableView?.isHidden = true
    }
}

extension OrderStatuslViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = OrderStatusCell.orderStatusCell(tableView: tableView)
        cell.orderStatus = orderStatuses![indexPath.row]
        
        if indexPath.row == 0 {
            cell.orderStateType = .Top
        } else if indexPath.row == orderStatuses!.count - 1 {
            cell.orderStateType = .Bottom
        } else {
            cell.orderStateType = .Middle
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return orderStatuses?.count ?? 0
    }
    
}
