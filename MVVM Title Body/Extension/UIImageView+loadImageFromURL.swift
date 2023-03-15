//
//  UIImageView+loadImageFromURL.swift
//  MVVM Title Body
//
//  Created by Teguh Wibowo Wijaya on 15/03/23.
//

import UIKit


extension UIImageView {
    func loadImage(from url: String, failImage: UIImage?) {
        guard let url = URL(string: url)
        else { return self.image = failImage }
        
        var getImageService = GetImageService()
        getImageService.set(url: url)
        
        getImageService.callGetImage { response in
            DispatchQueue.main.async {
                switch response {
                case .success(let image):
                    self.image = image
                    
                case .failure(_):
                    self.image = failImage
                }
            }
        }
    }
}
