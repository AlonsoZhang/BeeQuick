//
//  MyAdressViewController.swift
//  BeeQuick
//
//  Created by Alonso on 2016/10/23.
//  Copyright © 2016年 Alonso. All rights reserved.
//

import UIKit

class MyAdressViewController: BaseViewController {
    
    private var addAdressButton: UIButton?
    private var nullImageView = UIView()
    var adressTableView: LFBTableView?
    var adresses: [Adress]? {
        didSet {
            if adresses?.count == 0 {
                nullImageView.isHidden = false
                adressTableView?.isHidden = true
            } else {
                nullImageView.isHidden = true
                adressTableView?.isHidden = false
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        buildNavigationItem()
        
        buildAdressTableView()
        
        buildNullImageView()
        
        loadAdressData()
        
        buildBottomAddAdressButtom()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        navigationController?.setNavigationBarHidden(false, animated: animated)
    }
    
    private func buildNavigationItem() {
        navigationItem.title = "我的收获地址"
    }
    
    private func buildAdressTableView() {
        adressTableView = LFBTableView(frame: view.bounds, style: UITableViewStyle.plain)
        adressTableView?.frame.origin.y += 10;
        adressTableView?.backgroundColor = UIColor.clear
        adressTableView?.rowHeight = 80
        adressTableView?.delegate = self
        adressTableView?.dataSource = self
        view.addSubview(adressTableView!)
    }
    
    private func buildNullImageView() {
        nullImageView.backgroundColor = UIColor.clear
        nullImageView.frame = CGRect(x:0, y:0, width:200, height:200)
        nullImageView.center = view.center
        nullImageView.center.y -= 100
        view.addSubview(nullImageView)
        
        let imageView = UIImageView(image: UIImage(named: "v2_address_empty"))
        imageView.center.x = 100
        imageView.center.y = 100
        nullImageView.addSubview(imageView)
        
        let label = UILabel(frame: CGRect(x:0, y:imageView.frame.maxY + 10, width:200, height:20))
        label.textColor = UIColor.lightGray
        label.textAlignment = NSTextAlignment.center
        label.font = UIFont.systemFont(ofSize: 14)
        label.text = "你还没有地址哦~"
        nullImageView.addSubview(label)
    }
    
    private func loadAdressData() {
        weak var tmpSelf = self
        AdressData.loadMyAdressData { (data, error) -> Void in
            if error == nil {
                if data?.data?.count != 0 {
                    tmpSelf!.adresses = data!.data
                    tmpSelf!.adressTableView?.isHidden = false
                    tmpSelf!.adressTableView?.reloadData()
                    tmpSelf!.nullImageView.isHidden = true
                } else {
                    tmpSelf!.adressTableView?.isHidden = true
                    tmpSelf!.nullImageView.isHidden = false
                }
            }
        }
    }
    
    private func buildBottomAddAdressButtom() {
        let bottomView = UIView(frame: CGRect(x:0, y:ScreenHeight - 60 - 64, width:ScreenWidth, height:60))
        bottomView.backgroundColor = UIColor.white
        view.addSubview(bottomView)
        
        addAdressButton = UIButton(frame: CGRect(x:ScreenWidth * 0.15, y:12, width:ScreenWidth * 0.7, height:60 - 12 * 2))
        addAdressButton?.backgroundColor = LFBNavigationYellowColor
        addAdressButton?.setTitle("+ 新增地址", for: UIControlState.normal)
        addAdressButton?.setTitleColor(UIColor.black, for: .normal)
        addAdressButton?.layer.masksToBounds = true
        addAdressButton?.layer.cornerRadius = 8
        addAdressButton?.titleLabel?.font = UIFont.systemFont(ofSize: 15)
        addAdressButton?.addTarget(self, action: #selector(MyAdressViewController.addAdressButtonClick), for: UIControlEvents.touchUpInside)
        bottomView.addSubview(addAdressButton!)
    }
    
    // MARK: - Action
    func addAdressButtonClick() {
        let editVC = EditAdressViewController()
        editVC.topVC = self
        editVC.vcType = EditAdressViewControllerType.Add
        navigationController?.pushViewController(editVC, animated: true)
    }
}


extension MyAdressViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return adresses?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        weak var tmpSelf = self
        let cell = AdressCell.adressCell(tableView: tableView, indexPath: indexPath as NSIndexPath) { (cellIndexPathRow) -> Void in
            let editAdressVC = EditAdressViewController()
            editAdressVC.topVC = tmpSelf
            editAdressVC.vcType = EditAdressViewControllerType.Edit
            editAdressVC.currentAdressRow = indexPath.row
            tmpSelf!.navigationController?.pushViewController(editAdressVC, animated: true)
        }
        cell.adress = adresses![indexPath.row]
        
        return cell
    }
    
}