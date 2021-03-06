//
//  AppDependencies.swift
//  RedditApp
//
//  Created by Manuel Munoz on 05/03/2020.
//  Copyright © 2020 Manuel Munoz. All rights reserved.
//

import Foundation

class AppDependencies {
    
    let redditRepository: RedditRepository
    let userDefaultsHandler = UserDefaultsHandler()
    let redditOAuthHandler: RedditOAuthHandler
    let imageDownloader = ImageDownloader()
    
    init() {
        redditRepository = RedditRepository(userDefaultsHandler: userDefaultsHandler)
        redditOAuthHandler = RedditOAuthHandler(userDefaultsHandler: userDefaultsHandler)
    }
}
