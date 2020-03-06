//
//  PostTableViewCell.swift
//  RedditApp
//
//  Created by Manuel Munoz on 06/03/2020.
//  Copyright © 2020 Manuel Munoz. All rights reserved.
//

import UIKit

class PostTableViewCell: UITableViewCell {

    @IBOutlet var title: UILabel!
    @IBOutlet var author: UILabel!
    @IBOutlet var createdAt: UILabel!
    @IBOutlet var numOfComments: UILabel!
    @IBOutlet var read: UILabel!

    func configure(with post: Post) {
        title.text = post.title
        author.text = post.author
        read.text = post.read ? "read" : "unread"
        read.textColor = post.read ? UIColor.green : UIColor.red
        numOfComments.text = post.numberOfComments
        
        let now = Date()
        let difference = Calendar.current.dateComponents([.hour], from: post.createdAt, to: now)
        if let hourDiff = difference.hour {
            createdAt.text = "\(hourDiff) hours ago"
        } else {
            createdAt.text = "now"
        }
    }
}
