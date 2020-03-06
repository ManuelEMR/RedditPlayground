//
//  UserDefaultsHandler.swift
//  RedditApp
//
//  Created by Manuel Munoz on 05/03/2020.
//  Copyright © 2020 Manuel Munoz. All rights reserved.
//

import Foundation

class UserDefaultsHandler {
    
    var accessToken: String? {
        set {
            UserDefaults.standard.set(newValue, forKey: "access_token")
        }
        get {
            UserDefaults.standard.string(forKey: "access_token")
        }
    }
    
    var refreshToken: String? {
        set {
            UserDefaults.standard.set(newValue, forKey: "refresh_token")
        }
        get {
            UserDefaults.standard.string(forKey: "refresh_token")
        }
    }
}
