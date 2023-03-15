//
//  ViewController.swift
//  MVVM Title Body
//
//  Created by Teguh Wibowo Wijaya on 14/03/23.
//

import UIKit

enum UserPostsSection: Int {
    case userPosts
    case album
}

class UserPostsViewController: UIViewController {
    
    @IBOutlet weak var userPostsTableView: UITableView!
    
    var userPostViewModel: UserPostViewModel?

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        setupViewModel()
        setupTableView()
    }
    
    func setupViewModel() {
        userPostViewModel = UserPostViewModel()
        userPostViewModel?.delegate = self
    }
    
    func setupTableView() {
        userPostsTableView.delegate = self
        userPostsTableView.dataSource = self
        
        userPostsTableView.register(UINib(nibName: UserPostTableViewCell.identifier, bundle: nil), forCellReuseIdentifier: UserPostTableViewCell.identifier)
        
        userPostsTableView.register(UINib(nibName: AlbumTableViewCell.identifier, bundle: nil), forCellReuseIdentifier: AlbumTableViewCell.identifier)
    }
}

extension UserPostsViewController: UserPostViewModelDelegate {
//    func onUserPostFetched(userPosts: [UserPostModel]?, errorMessage: String?) {
//        if let userPosts = userPosts {
//            self.userPosts = userPosts
//            DispatchQueue.main.async {
//                self.userPostsTableView.reloadData()
//            }
//        }
//    }
    
    func onDataFetched(refreshOn section: UserPostsSection) {
        DispatchQueue.main.async {
//            self.userPostsTableView.reloadSections(IndexSet(integer: section.rawValue), with: .automatic)
            self.userPostsTableView.reloadData()

        }
    }
}

extension UserPostsViewController: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch UserPostsSection(rawValue: section) {
        case .userPosts:
            return userPostViewModel?.userPosts?.count ?? 0
        case .album:
            return userPostViewModel?.albums?.count ?? 0
        default:
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        switch UserPostsSection(rawValue: indexPath.section) {
        case .userPosts:
            guard let userPost = userPostViewModel?.userPosts?[indexPath.row],
                let userPostCell = tableView.dequeueReusableCell(withIdentifier: UserPostTableViewCell.identifier, for: indexPath) as? UserPostTableViewCell
            else { return UITableViewCell() }
            
            userPostCell.setupCell(with: userPost)
            
            return userPostCell
            
            
        case .album:
            guard let album = userPostViewModel?.albums?[indexPath.row],
                let albumCell = tableView.dequeueReusableCell(withIdentifier: AlbumTableViewCell.identifier, for: indexPath) as? AlbumTableViewCell
            else { return UITableViewCell() }
            
            albumCell.setupCell(album: album)
            
            return albumCell
            
            
        default:
            return UITableViewCell()
        }
    }
}

