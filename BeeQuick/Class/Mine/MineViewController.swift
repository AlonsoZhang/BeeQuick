//
//  MineViewController.swift
//  BeeQuick
//
//  Created by Alonso on 16/10/5.
//  Copyright © 2016年 Alonso. All rights reserved.
//

import UIKit

class MineViewController: BaseViewController{

    private var headView: MineHeadView!
    private var tableView: UITableView!
    private var headViewHeight: CGFloat = 150
    private var tableHeadView: MineTabeHeadView!
    fileprivate lazy var mines: [MineCellModel] = {
        let mines = MineCellModel.loadMineCellModels()
        return mines
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.navigationBar.isHidden = true
        _ = mines[0];
        buildUI()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    // MARK:- Private Method
    // MARK: Build UI
    private func buildUI() {
        headView =  MineHeadView(frame: CGRect(x:0, y:0, width:ScreenWidth, height:headViewHeight), settingButtonClick: { () -> Void in
            print("设置button点击")
        })
        view.addSubview(headView)
        
        buildTableView()
    }
    
    private func buildTableView() {
        tableView = UITableView(frame: CGRect(x:0, y:headViewHeight, width:ScreenWidth,height:ScreenHeight - headViewHeight), style: .grouped)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.rowHeight = 46
        tableView.separatorStyle = .none
        view.addSubview(tableView)
        tableHeadView = MineTabeHeadView(frame: CGRect(x:0, y:0, width:ScreenWidth, height:70))
        
        tableView.tableHeaderView = tableHeadView
    }
}

/// MARK:- UITableViewDataSource UITableViewDelegate
extension MineViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell{
        
        let cell = MineCell.cellFor(tableView: tableView)
        if 0 == indexPath.section {
            
            cell.mineModel = mines[indexPath.row]
        } else if 1 == indexPath.section {
            cell.mineModel = mines[2]
        } else {
            if indexPath.row == 0 {
                cell.mineModel = mines[3]
            } else {
                cell.mineModel = mines[4]
            }
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 10
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 0.1
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 3
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if 0 == section {
            return 2
        } else if (1 == section) {
            return 1
        } else {
            return 2
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if 0 == indexPath.section {
            if 0 == indexPath.row {
                
            } else {
                
            }
        } else if 1 == indexPath.section {
            
        } else if 2 == indexPath.section {
            
        }
    }
}
