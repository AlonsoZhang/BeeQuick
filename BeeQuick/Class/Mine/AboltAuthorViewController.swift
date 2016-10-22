//
//  AboltAuthorViewController.swift
//  BeeQuick
//
//  Created by Alonso on 16/10/17.
//  Copyright © 2016年 Alonso. All rights reserved.
//

import UIKit

class AboltAuthorViewController: BaseViewController {

    private var authorLabel: UILabel!
    private var gitHubLabel: UILabel!
    private var sinaWeiBoLabel: UILabel!
    private var blogLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        buildAuthorImageView()
        bulidTextLabel()
        bulidGitHubLabel()
        bulidSinaLabel()
        bulidBlogLabel()
    }
    
    // MARK: Build UI
    private func buildAuthorImageView() {
        navigationItem.title = "关于作者"
        
        let authorImageView = UIImageView(frame: CGRect(x:(ScreenWidth - 100) * 0.5, y:50, width:100, height:100))
        authorImageView.image = UIImage(named: "author")
        authorImageView.layer.masksToBounds = true
        authorImageView.layer.cornerRadius = 15
        view.addSubview(authorImageView)
    }
    
    private func bulidTextLabel() {
        authorLabel = UILabel()
        authorLabel.text = "维尼的小熊"
        authorLabel.sizeToFit()
        authorLabel.center.x = ScreenWidth * 0.5
        authorLabel.frame.origin.y = 170
        view.addSubview(authorLabel)
    }
    
    private func bulidGitHubLabel() {
        //frame: CGRectMake((ScreenWidth - gitHubLabel.width) * 0.5, CGRectGetMaxY(authorLabel.frame) + 10, gitHubLabel.width, gitHubLabel.height)
        gitHubLabel = UILabel()
        bulidTextLabel(label: gitHubLabel, text: "GitHub: " + "\(GitHubURLString)", tag: 1)
    }
    
    private func bulidSinaLabel() {
        sinaWeiBoLabel = UILabel()
        bulidTextLabel(label: sinaWeiBoLabel, text: "新浪微博: " + "\(SinaWeiBoURLString)", tag: 2)
    }
    private func bulidBlogLabel() {
        blogLabel = UILabel()
        bulidTextLabel(label: blogLabel, text: "技术博客: " + "\(BlogURLString)", tag: 3)
    }
    
    private func bulidTextLabel(label: UILabel, text: String, tag: Int) {
        label.text = text
        label.font = UIFont.systemFont(ofSize: 13)
        label.sizeToFit()
        label.isUserInteractionEnabled = true
        label.textColor = UIColor.colorWithCustom(r: 100, g: 100, b: 100)
        label.numberOfLines = 0
        
        switch tag {
        case 1: label.frame = CGRect(x:40, y:authorLabel.frame.maxY + 20, width:gitHubLabel.width, height:gitHubLabel.height + 10)
            break
        case 2: label.frame = CGRect(x:40, y:gitHubLabel.frame.maxY + 10, width:ScreenWidth, height:sinaWeiBoLabel.height + 10)
            break
        case 3: label.frame = CGRect(x:40, y:sinaWeiBoLabel.frame.maxY + 10, width:ScreenWidth - 40 - 50, height:40)
        default:break
        }
        
        label.tag = tag
        view.addSubview(label)
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(AboltAuthorViewController.textLabelClick(tap:)))
        label.addGestureRecognizer(tap)
    }
    
    // MARK: - Action
    func textLabelClick(tap: UITapGestureRecognizer) {
        switch tap.view!.tag {
        case 1: UIApplication.shared.open(NSURL(string: GitHubURLString) as! URL, options: [:], completionHandler: nil)
            break
        case 2: UIApplication.shared.open(NSURL(string: SinaWeiBoURLString) as! URL, options: [:], completionHandler: nil)
            break
        default: UIApplication.shared.open(NSURL(string: BlogURLString) as! URL, options: [:], completionHandler: nil)
            break
        }
    }
}
