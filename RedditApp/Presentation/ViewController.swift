//
//  ViewController.swift
//  RedditApp
//
//  Created by Manuel Munoz on 03/03/2020.
//  Copyright © 2020 Manuel Munoz. All rights reserved.
//

import UIKit
import WebKit

class ViewController: UIViewController {

    lazy var webView: WKWebView = {
        let config = WKWebViewConfiguration()
        config.applicationNameForUserAgent = "manuelemr-v1"
        let wkView = WKWebView(frame: view.bounds, configuration: config)
        wkView.uiDelegate = self
        view.addSubview(wkView)
        wkView.frame = view.bounds
        return wkView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        let url = URL(string: "https://www.reddit.com/api/v1/authorize?client_id=KuUP0BXhatcrFA&response_type=code&state=hello&redirect_uri=http://manuelemr/reddit&duration=permanent&scope=read")
        let urlRequest = URLRequest(url: url!)
        webView.load(urlRequest)
    }


}

extension ViewController: WKUIDelegate {
    
}
