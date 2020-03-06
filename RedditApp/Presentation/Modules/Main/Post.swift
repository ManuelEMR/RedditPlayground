//
//  Post.swift
//  RedditApp
//
//  Created by Manuel Munoz on 06/03/2020.
//  Copyright © 2020 Manuel Munoz. All rights reserved.
//

import Foundation

struct Post {
    let title: String
    let author: String
    let createdAt: Date
    let thumbnail: String?
    let numberOfComments: String
    let read: Bool
    
    init(model: PostModel) {
        self.title = model.title
        self.author = model.author
        self.thumbnail = model.thumbnail
        self.numberOfComments = String(model.numComments)
        self.read = false
        self.createdAt = Date(timeIntervalSince1970: model.created)
    }
}
