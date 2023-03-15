//
//  AlbumModel.swift
//  MVVM Title Body
//
//  Created by Teguh Wibowo Wijaya on 15/03/23.
//

import Foundation

struct AlbumModel: Decodable {
    let albumId: Int
    let id: Int
    let title: String
    let url: String
    let thumbnailUrl: String
}
