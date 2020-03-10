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
    private var _posts: [Post] = []
    private var posts: [Post] {
        set {
            let oldValue = _posts
            _posts = newValue
            if oldValue.isEmpty {
                let indexPaths = newValue.indices.map { IndexPath(row: $0, section: 0) }
                tableView.insertRows(at: indexPaths, with: .left)
            } else if newValue.isEmpty {
                let indexPaths = oldValue.indices.map { IndexPath(row: $0, section: 0) }
                tableView.deleteRows(at: indexPaths, with: .left)
            } else if oldValue.count == newValue.count { // this is very specific as we dont support pagination yet, only refresh
                let indexPaths = newValue.indices.map { IndexPath(row: $0, section: 0) }
                tableView.reloadRows(at: indexPaths, with: .left)
            }
        }
        get {
            _posts
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setupViews()
        requestPosts()
    }
    
    private func setupViews() {
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "CLEAN", style: .plain, target: self, action: #selector(deleteAll))
        
        refreshControl.addTarget(self, action: #selector(requestPosts), for: .valueChanged)
        tableView.refreshControl = refreshControl
        tableView.dataSource = self
    }
    
    @objc private func requestPosts() {
        refreshControl.beginRefreshing()
        redditRepository.fetchTopPosts { [weak self] (result) in
            switch result {
            case.success(let list):
                DispatchQueue.main.async {
                    let posts = list.data.children.map { $0.data }
                    .map { Post(model: $0) }
                    self?.posts = posts
                    self?.refreshControl.endRefreshing()
                }
                break
            case .failure(let err):
                DispatchQueue.main.async {
                    self?.view.window?.rootViewController = LoginViewController.instantiate(storyboard: .auth)
                }
                print(err)
            }
        }
    }
    
    @objc private func deleteAll() {
        posts = []
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
