//
//  UserPostsViewModel.swift
//  MVVM Title Body
//
//  Created by Teguh Wibowo Wijaya on 14/03/23.
//

import Foundation

struct UserPostSectionModel {
    let url: String
    let sectionType: UserPostsSection
    let sectionModel: Any
}

protocol UserPostViewModelDelegate {
    func onDataFetched(refreshOn section: UserPostsSection)
}

class UserPostViewModel {
    typealias Completion = ([UserPostModel]?, String?) -> Void
    
    var urls = [URL?]()
    var getAPIService: GetAPIService?
    
    var userPosts: [UserPostModel]?
    var albums: [AlbumModel]?
    var errorMessages: [String] = [String]()
    
    var delegate: UserPostViewModelDelegate? {
        didSet {
            fetchAllData()
        }
    }
    
    
//    var bindViewModelToController: Completion = {_,_ in }
    
//    init(with binding: @escaping Completion) {
    init() {
//        self.bindViewModelToController = binding
        urls.append(contentsOf: [
            URL(string: "https://jsonplaceholder.typicode.com/posts"),
            URL(string: "https://jsonplaceholder.typicode.com/photos")
        ])
        
        getAPIService = GetAPIService()
    }
    
    func fetchAllData() {
        errorMessages = [String]()
        let dispatchGroup = DispatchGroup()
        

        getAPIService?.set(url: urls[0])
        dispatchGroup.enter()
        getAPIService?.callGetAPI(model: [UserPostModel].self) { result in
            switch result {
            case .success(let modelData):
                self.userPosts = modelData
                self.delegate?.onDataFetched(refreshOn: .userPosts)
                
            case .failure(let error):
                guard let errorMessage = self.getAPIService?.getCallAPIErrorMessage(with: error)
                else { break }
//                completion(nil, errorMessage)
                self.errorMessages.append(errorMessage)
            }
        }
        dispatchGroup.leave()
        
        getAPIService?.set(url: urls[1])
        dispatchGroup.enter()
        getAPIService?.callGetAPI(model: [AlbumModel].self) { result in
            switch result {
            case .success(let modelData):
                self.albums = modelData
                self.delegate?.onDataFetched(refreshOn: .album)
                
            case .failure(let error):
                guard let errorMessage = self.getAPIService?.getCallAPIErrorMessage(with: error)
                else { break }
//                completion(nil, errorMessage)
                self.errorMessages.append(errorMessage)
            }
        }
        dispatchGroup.leave()
    }
}
