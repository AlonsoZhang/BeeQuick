//
//  CoupinRuleViewController.swift
//  BeeQuick
//
//  Created by Alonso on 16/10/17.
//  Copyright © 2016年 Alonso. All rights reserved.
//

import UIKit

class CoupinRuleViewController: BaseViewController {

    private let webView = UIWebView(frame: CGRect(x:0, y:0, width:ScreenWidth, height:ScreenHeight - NavigationH))
    private let loadProgressAnimationView: LoadProgressAnimationView = LoadProgressAnimationView(frame: CGRect(x:0, y:0, width:ScreenWidth, height:3))
    var loadURLStr: String? {
        didSet {
            webView.loadRequest(NSURLRequest(URL: NSURL(string: loadURLStr!)!))
        }
    }
    
    var navTitle: String? {
        didSet {
            navigationItem.title = navTitle
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = UIColor.whiteColor()
        
        buildWebView()
        webView.addSubview(loadProgressAnimationView)
    }
    
    private func buildWebView() {
        webView.delegate = self
        webView.backgroundColor = UIColor.whiteColor()
        view.addSubview(webView)
    }
}

extension CoupinRuleViewController: UIWebViewDelegate {
    
    func webViewDidStartLoad(webView: UIWebView) {
        loadProgressAnimationView.startLoadProgressAnimation()
    }
    
    func webViewDidFinishLoad(webView: UIWebView) {
        loadProgressAnimationView.endLoadProgressAnimation()
    }
}
