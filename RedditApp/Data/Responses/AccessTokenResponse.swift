//
//  AccessTokenResponse.swift
//  RedditApp
//
//  Created by Manuel Munoz on 05/03/2020.
//  Copyright © 2020 Manuel Munoz. All rights reserved.
//

import Foundation

struct AccessTokenResponse: Decodable {
    let accessToken: String
    let tokenType: String
    let expiresIn: Double
    let scope: String
    let state: String
}
