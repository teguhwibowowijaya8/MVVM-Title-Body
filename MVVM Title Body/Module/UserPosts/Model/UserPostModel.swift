//
//  UserPostModel.swift
//  MVVM Title Body
//
//  Created by Teguh Wibowo Wijaya on 14/03/23.
//

import Foundation

struct UserPostModel: Decodable {
    let userId: Int
    let id: Int
    let title: String
    let body: String
}
