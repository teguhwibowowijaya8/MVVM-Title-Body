//
//  UserPostTableViewCell.swift
//  MVVM Title Body
//
//  Created by Teguh Wibowo Wijaya on 14/03/23.
//

import UIKit

class UserPostTableViewCell: UITableViewCell {
    static let identifier = "UserPostTableViewCell"
    
    @IBOutlet weak var userIdLabel: UILabel!
    @IBOutlet weak var userPostIdLabel: UILabel!
    @IBOutlet weak var postTitleLabel: UILabel! {
        didSet {
            postTitleLabel.numberOfLines = 2
            postTitleLabel.adjustsFontSizeToFitWidth = true
        }
    }
    
    @IBOutlet weak var postBodyTextView: UITextView! {
        didSet {
            postBodyTextView.backgroundColor = .clear
            postBodyTextView.textContainerInset = UIEdgeInsets(top: 8, left: -3, bottom: 5, right: -3)
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func setupCell(with userPost: UserPostModel) {
        userIdLabel.text = "User Id: \(userPost.userId)"
        userPostIdLabel.text = "User Post Id: \(userPost.id)"
        postTitleLabel.text = "Title: \(userPost.title)"
        postBodyTextView.text = userPost.body
    }
}
