//
//  PostsViewController.swift
//  RedditApp
//
//  Created by Manuel Munoz on 06/03/2020.
//  Copyright © 2020 Manuel Munoz. All rights reserved.
//

import UIKit

class PostsViewController: UIViewController {

    @IBOutlet var tableView: UITableView!
    
    let redditRepository = UIApplication.dependencies.redditRepository
    
    override func viewDidLoad() {
        super.viewDidLoad()

        requestPosts()
    }
    
    private func requestPosts() {
        redditRepository.fetchTopPosts { (result) in
            switch result {
            case.success(let list):
                print(list)
                break
            case .failure(let err):
                print(err)
            }
        }
    }
}
