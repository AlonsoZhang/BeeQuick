//
//  WebViewController.swift
//  BeeQuick
//
//  Created by Alonso on 2016/10/30.
//  Copyright © 2016年 Alonso. All rights reserved.
//

import UIKit

class WebViewController: BaseViewController {
    
    private var webView = UIWebView(frame: ScreenBounds)
    private var urlStr: String?
    fileprivate let loadProgressAnimationView: LoadProgressAnimationView = LoadProgressAnimationView(frame: CGRect(x:0, y:0, width:ScreenWidth, height:3))
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        
        view.addSubview(webView)
        webView.addSubview(loadProgressAnimationView)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    convenience init(navigationTitle: String, urlStr: String) {
        self.init(nibName: nil, bundle: nil)
        navigationItem.title = navigationTitle
        webView.loadRequest(NSURLRequest(url: NSURL(string: urlStr)! as URL) as URLRequest)
        self.urlStr = urlStr
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        buildRightItemBarButton()
        
        view.backgroundColor = UIColor.colorWithCustom(r: 230, g: 230, b: 230)
        webView.backgroundColor = UIColor.colorWithCustom(r: 230, g: 230, b: 230)
        webView.delegate = self
        webView.scrollView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: 64, right: 0)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.navigationBar.barTintColor = LFBNavigationBarWhiteBackgroundColor
    }
    
    private func buildRightItemBarButton() {
        let rightButton = UIButton(frame: CGRect(x:0, y:0, width:60, height:44))
        rightButton.setImage(UIImage(named: "v2_refresh"), for: UIControlState.normal)
        rightButton.contentEdgeInsets = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: -53)
        rightButton.addTarget(self, action: #selector(WebViewController.refreshClick), for: UIControlEvents.touchUpInside)
        navigationItem.rightBarButtonItem = UIBarButtonItem(customView: rightButton)
    }
    
    // MARK: - Action
    func refreshClick() {
        if urlStr != nil && urlStr!.characters.count > 1 {
            webView.loadRequest(NSURLRequest(url: NSURL(string: urlStr!)! as URL) as URLRequest)
        }
    }
}

extension WebViewController: UIWebViewDelegate {
    
    func webViewDidStartLoad(_ webView: UIWebView) {
        loadProgressAnimationView.startLoadProgressAnimation()
    }
    
    func webViewDidFinishLoad(_ webView: UIWebView) {
        loadProgressAnimationView.endLoadProgressAnimation()
    }
}
