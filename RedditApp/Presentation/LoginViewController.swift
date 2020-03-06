//
//  ViewController.swift
//  RedditApp
//
//  Created by Manuel Munoz on 03/03/2020.
//  Copyright © 2020 Manuel Munoz. All rights reserved.
//

import UIKit
import WebKit

class LoginViewController: UIViewController {

    lazy var webView: WKWebView = {
        let config = WKWebViewConfiguration()
        config.applicationNameForUserAgent = "manuelemr-v1"
        let wkView = WKWebView(frame: view.bounds, configuration: config)
        wkView.navigationDelegate = self
        wkView.scrollView.maximumZoomScale = 5
        view.addSubview(wkView)
        wkView.frame = view.bounds
        return wkView
    }()
    
    private let oauthHandler: RedditOAuthHandler = UIApplication.dependencies.redditOAuthHandler
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        let url = URL(string: oauthHandler.authorizeURL)
        let urlRequest = URLRequest(url: url!)
        webView.load(urlRequest)
    }
}

extension LoginViewController: WKNavigationDelegate {
    public func webView(_ webView: WKWebView, decidePolicyFor navigationAction: WKNavigationAction, decisionHandler: @escaping (WKNavigationActionPolicy) -> Void) {
        guard let url = navigationAction.request.url,
            !url.absoluteString.hasPrefix("http://"),
            !url.absoluteString.hasPrefix("https://"),
            UIApplication.shared.canOpenURL(url) else {
                decisionHandler(.allow)
                return
        }
        
        let components = URLComponents(url: url, resolvingAgainstBaseURL: true)
        if let stateValue = components?.queryItems?.first(where: { $0.name == "state" })?.value,
        stateValue == oauthHandler.state {
            UIApplication.shared.open(url, options: [:], completionHandler: nil)
            decisionHandler(.cancel)
        }
    }
}
