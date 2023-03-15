//
//  AlbumTableViewCell.swift
//  MVVM Title Body
//
//  Created by Teguh Wibowo Wijaya on 15/03/23.
//

import UIKit

class AlbumTableViewCell: UITableViewCell {
    static let identifier = "AlbumTableViewCell"
    
    
    @IBOutlet weak var albumImageView: UIImageView!
    @IBOutlet weak var albumIdLabel: UILabel!
    @IBOutlet weak var albumPhotoIdLabel: UILabel!
    @IBOutlet weak var photoTitleLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func setupCell(album: AlbumModel) {
        albumImageView.loadImage(from: album.thumbnailUrl, failImage: UIImage(systemName: "star"))
        
        albumIdLabel.text = "Album ID: \(album.albumId)"
        albumPhotoIdLabel.text = "Image ID: \(album.id)"
        photoTitleLabel.text = album.title
        
    }
    
}
