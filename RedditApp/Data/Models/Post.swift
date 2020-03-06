//
//  Post.swift
//  RedditApp
//
//  Created by Manuel Munoz on 06/03/2020.
//  Copyright © 2020 Manuel Munoz. All rights reserved.
//

import Foundation

struct Post: Decodable {
    let title: String
    let author: String
    let created: Double
    let thumbnail: String?
    let numComments: Int
}
