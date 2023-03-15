//
//  GetImageService.swift
//  MVVM Title Body
//
//  Created by Teguh Wibowo Wijaya on 15/03/23.
//

import UIKit

enum GetImageServiceError: Error {
    case invalidUrl
    case fetchError(message: String)
    case noData
}

protocol GetImageServiceProtocol {
    mutating func set(url: URL?)
    
    func callGetImage(completion: @escaping (Result<UIImage?, GetImageServiceError>) -> Void)
}

struct GetImageService: GetImageServiceProtocol {
    private var url: URL?
    private var fetchDataService: FetchDataService?
    
    init() {
        fetchDataService = FetchDataService()
    }
    
    mutating func set(url: URL?) {
        self.url = url
    }
    
    func callGetImage(completion: @escaping (Result<UIImage?, GetImageServiceError>) -> Void) {
        guard let url = url
        else { return completion(.failure(.invalidUrl))}
        
        fetchDataService?.fecthData(url: url) { fetchResponse in
            switch fetchResponse {
            case .success(let imageData):
                let image = UIImage(data: imageData)
                return completion(.success(image))
                
            case .failure(let fetchError):
                switch fetchError {
                case .noData:
                    return completion(.failure(.noData))
                case .fetchError(let errorMessage):
                    return completion(.failure(.fetchError(message: errorMessage)))
                }
            }
        }
    }
    
    func getCallImageErrorMessage(with error: GetImageServiceError) -> String {
        switch error {
        case .fetchError(let message):
            return message
        case .noData:
            return "Image Data is Unavailable"
        case .invalidUrl:
            return "Invalid Image Url"
        }
    }
    
    
}
