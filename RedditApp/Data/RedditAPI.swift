//
//  RedditRequests.swift
//  RedditApp
//
//  Created by Manuel Munoz on 05/03/2020.
//  Copyright © 2020 Manuel Munoz. All rights reserved.
//

import Foundation

enum RedditAPI {
    case accessToken(code: String, redirectURI: String)
    
    var baseURL: String {
        "https://www.reddit.com/api/v1/"
    }
    
    var url: String {
        switch self {
        case .accessToken:
            return baseURL + "access_token"
        }
    }
    
    var method: String {
        switch self {
        case .accessToken:
            return "POST"
        }
    }
    
    var params: [String: Any] {
        switch self {
        case .accessToken(let code, let uri):
            return ["grant_type": "authorization_code",
                    "code": code,
                    "redirect_uri": uri]
        }
    }
    
    var headers: [String: String]? {
        switch self {
        case .accessToken:
            return ["Content-Type": "application/x-www-form-urlencoded"]
        }
    }
    
    var body: Data? {
        switch self {
        case .accessToken:
            var components = URLComponents()
            components.queryItems = params
                .map { URLQueryItem(name: $0.key, value: $0.value as? String) }
            return components.query?.data(using: .utf8)
        }
    }
}

