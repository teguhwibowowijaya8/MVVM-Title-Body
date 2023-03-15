//
//  GetAPIService.swift
//  MVVM Title Body
//
//  Created by Teguh Wibowo Wijaya on 14/03/23.
//

import Foundation

//typealias GetCompletion = (Result<T, Error>) -> Void

enum GetAPIServiceError: Error {
    case invalidUrl
    case fetchError(message: String)
    case noData
    case failedToDecode
}

protocol GetAPIServiceProtocol {
    mutating func set(url: URL?)
    
    func callGetAPI<T: Decodable>(model: T.Type, completion: @escaping (Result<T, GetAPIServiceError>) -> Void)
}

struct GetAPIService: GetAPIServiceProtocol {
    private var url: URL?
    private var fetchDataService: FetchDataService?
    private var parseResponseService: ParseResponseService?
    
    init() {
        self.fetchDataService = FetchDataService()
        self.parseResponseService = ParseResponseService()
    }
    
    mutating func set(url: URL?) {
        self.url = url
    }
    
    func callGetAPI<T>(
        model: T.Type,
        completion: @escaping (Result<T, GetAPIServiceError>) -> Void)
    where T : Decodable {
        guard let url = self.url
        else { return completion(.failure(.invalidUrl)) }
        
        fetchDataService?.fecthData(url: url) { result in
            switch result {
            case .success(let data):
                if let modelData = parseResponseService?.parseDataTo(model: model, from: data) {
                    return completion(.success(modelData))
                }
                return completion(.failure(.failedToDecode))
                
            case .failure(let fetchError):
                switch fetchError {
                case .fetchError(let errorMessage):
                    return completion(.failure(.fetchError(message: errorMessage)))
                case .noData:
                    return completion(.failure(.noData))
                }
            }
        }
    }
    
    func getCallAPIErrorMessage(with error: GetAPIServiceError) -> String {
        switch error {
        case .failedToDecode:
            return "Failed to Decode API Data"
        case .fetchError(let message):
            return message
        case .noData:
            return "No Data Available"
        case .invalidUrl:
            return "Invalid API Url"
        }
    }
    
    
}
