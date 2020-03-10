//
//  RedditOAuthHandler.swift
//  RedditApp
//
//  Created by Manuel Munoz on 04/03/2020.
//  Copyright © 2020 Manuel Munoz. All rights reserved.
//

import UIKit

class RedditOAuthHandler {
    static let redirectURI = "memapp://manuelemr.com/reddit"

    var state: String?
    
    private let userDefaultsHandler: UserDefaultsHandler
    
    init(userDefaultsHandler: UserDefaultsHandler) {
        self.userDefaultsHandler = userDefaultsHandler
    }
    
    var authorizeURL: String {
        let state = generateState()
        // strangely without the ".compact" it doesnt redirect on first login
        return "https://www.reddit.com/api/v1/authorize.compact?client_id=KuUP0BXhatcrFA&response_type=token&state=\(state)&redirect_uri=\(RedditOAuthHandler.redirectURI)&scope=read"
    }
    
    func generateState() -> String {
        let letters = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789"
        // just 10 chars
        let randomString = String((0..<10).map{ _ in letters.randomElement()! })
        state = randomString
        return randomString
    }
    
    func handleRedirectURL(_ url: URL) {
        var components = URLComponents()
        components.query = url.fragment
        
        guard let urlState = components.queryItems?.first(where: { $0.name == "state"})?.value,
            urlState == self.state,
            let accessToken = components.queryItems?.first(where: { $0.name == "access_token"})?.value else {
                return
        }
        
        userDefaultsHandler.accessToken = accessToken
        UIApplication.shared.windows.first?.rootViewController = PostsViewController.instantiate(storyboard: .main)
    }
}
