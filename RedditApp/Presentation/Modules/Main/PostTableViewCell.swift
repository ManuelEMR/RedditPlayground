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

    func configure(with post: Post) {
        title.text = post.title
    }
}
