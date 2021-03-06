//
//  HelpViewController.swift
//  BeeQuick
//
//  Created by Alonso on 16/10/17.
//  Copyright © 2016年 Alonso. All rights reserved.
//

import UIKit

enum HelpCellType: Int {
    case Phone = 0
    case Question = 1
}

class HelpViewController: BaseViewController {
    
    let margin: CGFloat = 20
    let backView: UIView = UIView(frame: CGRect(x:0, y:10, width:ScreenWidth, height:100))
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.title = "客服帮助"
        
        backView.backgroundColor = UIColor.white
        view.addSubview(backView)
        
        let phoneLabel = UILabel(frame: CGRect(x:20, y:0, width:ScreenWidth - margin, height:50))
        creatLabel(label: phoneLabel, text: "客服电话: 400-8484-842", type: .Phone)
        
        let arrowImageView = UIImageView(image: UIImage(named: "icon_go"))
        arrowImageView.frame = CGRect(x:ScreenWidth - 20, y:(50 - 10) * 0.5, width:5, height:10)
        backView.addSubview(arrowImageView)
        
        let lineView = UIView(frame: CGRect(x:margin, y:49.5, width:ScreenWidth - margin, height:1))
        lineView.backgroundColor = UIColor.gray
        lineView.alpha = 0.2
        backView.addSubview(lineView)
        
        let questionLabel = UILabel(frame: CGRect(x:margin, y:50, width:ScreenWidth - margin, height:50))
        creatLabel(label: questionLabel, text: "常见问题", type: .Question)
        
        let arrowImageView2 = UIImageView(image: UIImage(named: "icon_go"))
        arrowImageView2.frame = CGRect(x:ScreenWidth - 20, y:(50 - 10) * 0.5 + 50, width:5, height:10)
        backView.addSubview(arrowImageView2)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(false, animated: animated)
    }
    
    // MARK - Method
    private func creatLabel(label: UILabel, text: String, type: HelpCellType) {
        label.text = text
        label.isUserInteractionEnabled = true
        label.font = UIFont.systemFont(ofSize: 15)
        label.tag = type.hashValue
        backView.addSubview(label)
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(HelpViewController.cellClick(tap:)))
        label.addGestureRecognizer(tap)
    }
    
    // MARK: - Action
    func cellClick(tap: UITapGestureRecognizer) {
        
        switch tap.view!.tag {
        case HelpCellType.Phone.hashValue :
            let alert = UIAlertController(title: nil, message: "400-8484-842", preferredStyle: UIAlertControllerStyle.alert)
            let callAction = UIAlertAction(title: "拨打", style: UIAlertActionStyle.default, handler: { (self) in
                UIApplication.shared.open(NSURL(string: "tel:4008484842") as! URL, options: [:], completionHandler: nil)
            })

            alert.addAction(callAction)
            alert.addAction(UIAlertAction(title: "取消", style: UIAlertActionStyle.cancel, handler: nil))
            self.present(alert, animated: true, completion: nil)
            break
        case HelpCellType.Question.hashValue :
            let helpDetailVC = HelpDetailViewController()
            navigationController?.pushViewController(helpDetailVC, animated: true)
            break
        default : break
        }
        
    }
}
