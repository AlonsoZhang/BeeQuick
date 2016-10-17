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
        
        backView.backgroundColor = UIColor.whiteColor()
        view.addSubview(backView)
        
        let phoneLabel = UILabel(frame: CGRect(x:20, y:0, width:ScreenWidth - margin, height:50))
        creatLabel(phoneLabel, text: "客服电话: 400-8484-842", type: .Phone)
        
        let arrowImageView = UIImageView(image: UIImage(named: "icon_go"))
        arrowImageView.frame = CGRect(x:ScreenWidth - 20, y:(50 - 10) * 0.5, width:5, height:10)
        backView.addSubview(arrowImageView)
        
        let lineView = UIView(frame: CGRect(x:margin, y:49.5, width:ScreenWidth - margin, height:1))
        lineView.backgroundColor = UIColor.grayColor()
        lineView.alpha = 0.2
        backView.addSubview(lineView)
        
        let questionLabel = UILabel(frame: CGRect(x:margin, y:50, width:ScreenWidth - margin, height:50))
        creatLabel(questionLabel, text: "常见问题", type: .Question)
        
        let arrowImageView2 = UIImageView(image: UIImage(named: "icon_go"))
        arrowImageView2.frame = CGRect(x:ScreenWidth - 20, y:(50 - 10) * 0.5 + 50, width:5, height:10)
        backView.addSubview(arrowImageView2)
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(false, animated: animated)
    }
    
    // MARK - Method
    private func creatLabel(label: UILabel, text: String, type: HelpCellType) {
        label.text = text
        label.userInteractionEnabled = true
        label.font = UIFont.systemFontOfSize(15)
        label.tag = type.hashValue
        backView.addSubview(label)
        
        let tap = UITapGestureRecognizer(target: self, action: "cellClick:")
        label.addGestureRecognizer(tap)
    }
    
    // MARK: - Action
    func cellClick(tap: UITapGestureRecognizer) {
        
        switch tap.view!.tag {
        case HelpCellType.Phone.hashValue :
            let alertView = UIAlertView(title: "", message: "400-8484-842", delegate: self, cancelButtonTitle: "取消", otherButtonTitles: "拨打")
            alertView.show()
            break
        case HelpCellType.Question.hashValue :
            let helpDetailVC = HelpDetailViewController()
            navigationController?.pushViewController(helpDetailVC, animated: true)
            break
        default : break
        }
        
    }
    
}

extension HelpViewController: UIAlertViewDelegate {
    func alertView(alertView: UIAlertView, clickedButtonAtIndex buttonIndex: Int) {
        if buttonIndex == 1 {
            UIApplication.sharedApplication().openURL(NSURL(string: "tel:4008484842")!)
        }
    }
}
