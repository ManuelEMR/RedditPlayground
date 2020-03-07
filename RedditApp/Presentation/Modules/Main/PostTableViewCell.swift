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
    @IBOutlet var thumbnail: UIImageView!
    
    private let imageDownloader = UIApplication.dependencies.imageDownloader
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        contentView.layer.shadowColor = UIColor.black.cgColor
        contentView.layer.shadowOpacity = 0.4
        contentView.layer.shadowOffset = .zero
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        
        changeTextColor(darkMode: true)
    }

    func configure(with post: Post) {
        title.text = post.title
        author.text = post.author
        read.text = post.read ? "read" : "unread"
        read.textColor = post.read ? UIColor.green : UIColor.red
        numOfComments.text = post.numberOfComments
        
        let now = Date()
        let difference = Calendar.current.dateComponents([.hour], from: post.createdAt, to: now)
        if let hourDiff = difference.hour, hourDiff > 0 {
            createdAt.text = "\(hourDiff) hours ago"
        } else {
            createdAt.text = "now"
        }
        
        imageDownloader.download(urlString: post.thumbnail) { [weak self] result in
            switch result {
            case .success(let data):
                self?.thumbnail.image = UIImage(data: data)
            case .failure(let err):
                print(err)
                self?.thumbnail.image = UIImage()
                self?.changeTextColor(darkMode: false)
            }
        }
    }
    
    private func changeTextColor(darkMode: Bool) {
        self.title.textColor = darkMode ? .white : .black
        self.author.textColor = darkMode ? .white : .black
        numOfComments.textColor = darkMode ? .white : .black
    }
}
