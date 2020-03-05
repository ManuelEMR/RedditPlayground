//
//  RedditOAuthHandler.swift
//  RedditApp
//
//  Created by Manuel Munoz on 04/03/2020.
//  Copyright © 2020 Manuel Munoz. All rights reserved.
//

import Foundation

class RedditOAuthHandler {
    private let redirectURI = "memapp://manuelemr.com/reddit"
    
    var code: String?
    var state: String?
    
    func generateState() -> String {
        let letters = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789"
        // just 10 chars
        let randomString = String((0..<10).map{ _ in letters.randomElement()! })
        state = randomString
        return randomString
    }
    
    var authorizeURL: String {
        let state = generateState()
        return "https://www.reddit.com/api/v1/authorize?client_id=KuUP0BXhatcrFA&response_type=code&state=\(state)&redirect_uri=\(redirectURI)&duration=permanent&scope=read"
    }
}
