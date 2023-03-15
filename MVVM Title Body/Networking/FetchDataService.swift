//
//  FetchDataService.swift
//  MVVM Title Body
//
//  Created by Teguh Wibowo Wijaya on 15/03/23.
//

import Foundation

enum FetchURLError: Error {
    case fetchError(message: String)
    case noData
}

protocol FetchDataServiceProtocol {
    func fecthData(
        url: URL,
        completion: @escaping (Result<Data, FetchURLError>) -> Void
    )
}

struct FetchDataService: FetchDataServiceProtocol {
    func fecthData(
        url: URL,
        completion: @escaping (Result<Data, FetchURLError>) -> Void
    ) {
        URLSession.shared.dataTask(with: url) { data, response, error in
            if let error = error {
                return completion(.failure(.fetchError(message: "\(error)")))
            } else if let response = response as? HTTPURLResponse,
                      response.statusCode > 299 {
                return completion(.failure(.fetchError(message: "Fetch API Error with Status Code of \(response.statusCode)")))
            }

            if let data = data {
                return completion(.success(data))
            }
            
            return completion(.failure(.noData))
            
        }.resume()
    }
}
