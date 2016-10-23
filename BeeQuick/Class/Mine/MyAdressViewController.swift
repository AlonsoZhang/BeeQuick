//
//  MyAdressViewController.swift
//  BeeQuick
//
//  Created by Alonso on 2016/10/23.
//  Copyright © 2016年 Alonso. All rights reserved.
//

import UIKit

class MyAdressViewController: BaseViewController {
    var adressTableView: LFBTableView?
    var adresses: [Adress]?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        buildNavigationItem()
        
        buildAdressTableView()
        
        loadAdressData()
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
        adressTableView?.backgroundColor = UIColor.clear
        adressTableView?.rowHeight = 80
        adressTableView?.delegate = self
        adressTableView?.dataSource = self
        view.addSubview(adressTableView!)
        
    }
    
    private func loadAdressData() {
        weak var tmpSelf = self
        AdressData.loadMyAdressData { (data, error) -> Void in
            if error == nil {
                if data?.data?.count != 0 {
                    tmpSelf!.adresses = data!.data
                    tmpSelf!.adressTableView?.reloadData()
                } else {
                    tmpSelf!.showNullAdress()
                }
            }
        }
        
    }
    
    private func showNullAdress() {
        
    }
}

extension MyAdressViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return adresses?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return UITableViewCell()
    }
    
}
