//
//  Listing.swift
//  RedditApp
//
//  Created by Manuel Munoz on 06/03/2020.
//  Copyright © 2020 Manuel Munoz. All rights reserved.
//

import Foundation

struct Listing<T: Decodable>: Decodable {
    let before: String?
    let after: String?
    let children: [Thing<T>]
}
