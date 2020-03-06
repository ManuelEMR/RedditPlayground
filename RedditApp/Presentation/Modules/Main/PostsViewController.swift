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
    private let refreshControl = UIRefreshControl()
    
    private let redditRepository = UIApplication.dependencies.redditRepository
    private var posts: [Post] = [] {
        didSet {
            tableView.reloadData()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setupViews()
        requestPosts()
    }
    
    private func setupViews() {
        refreshControl.addTarget(self, action: #selector(requestPosts), for: .valueChanged)
        tableView.refreshControl = refreshControl
        tableView.dataSource = self
//        tableView.estimatedRowHeight = 44
//        tableView.rowHeight = UITableView.automaticDimension
    }
    
    @objc private func requestPosts() {
        refreshControl.beginRefreshing()
        redditRepository.fetchTopPosts { [weak self] (result) in
            switch result {
            case.success(let list):
                DispatchQueue.main.async {
                    self?.posts = list.data.children.map { $0.data }
                        .map { Post(model: $0) }
                    self?.refreshControl.endRefreshing()
                }
                break
            case .failure(let err):
                print(err)
            }
        }
    }
}

extension PostsViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        posts.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "PostTableViewCell", for: indexPath) as? PostTableViewCell else {
            return UITableViewCell()
        }
        
        cell.configure(with: posts[indexPath.row])
        return cell
    }
    
    
}
