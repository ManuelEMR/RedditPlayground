//
//  RedditRequests.swift
//  RedditApp
//
//  Created by Manuel Munoz on 05/03/2020.
//  Copyright © 2020 Manuel Munoz. All rights reserved.
//

import Foundation

protocol API {
    var baseURL: String { get }
    var url: String { get }
    var method: String { get }
    var params: [String: Any] { get }
    var headers: [String: String]? { get }
    var body: Data? { get }
    
}

enum RedditAPI: API {
    case accessToken(code: String, redirectURI: String)
    case top(count: Int?, limit: Int)
    
    var baseURL: String {
        "https://oauth.reddit.com/"
    }
    
    var url: String {
        switch self {
        case .accessToken:
            return baseURL + "access_token"
        case .top(let _, let limit):
            return baseURL + "top?limit=\(limit)"
        }
    }
    
    var method: String {
        switch self {
        case .accessToken:
            return "POST"
        case .top:
            return "GET"
        }
    }
    
    var params: [String: Any] {
        switch self {
        case .accessToken(let code, let uri):
            return ["grant_type": "authorization_code",
                    "code": code,
                    "redirect_uri": uri]
        case .top(let count, let limit):
            var p = ["limit": limit]
            if let count = count {
                p["count"] = count
            }
            return p
        }
    }
    
    var headers: [String: String]? {
        switch self {
        case .accessToken:
            return ["Content-Type": "application/x-www-form-urlencoded"]
        case .top:
            return ["Content-Type": "application/json"]
        }
    }
    
    var body: Data? {
        switch self {
        case .accessToken:
            var components = URLComponents()
            components.queryItems = params
                .map { URLQueryItem(name: $0.key, value: $0.value as? String) }
            return components.query?.data(using: .utf8)
        case .top:
            return nil
        }
    }
}

