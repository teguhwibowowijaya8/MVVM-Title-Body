//
//  ParseResponseService.swift
//  MVVM Title Body
//
//  Created by Teguh Wibowo Wijaya on 15/03/23.
//

import Foundation

protocol ParseResponseServiceProtocol {
    func parseDataTo<T: Decodable> (model: T.Type, from data: Data) -> T?
}

struct ParseResponseService: ParseResponseServiceProtocol {
    func parseDataTo<T>(model: T.Type, from data: Data) -> T? where T : Decodable {
        do {
            let decoder = JSONDecoder()
            let modelData = try decoder.decode(model, from: data)
            return modelData
            
        } catch _ {
            return nil
        }
    }
}
