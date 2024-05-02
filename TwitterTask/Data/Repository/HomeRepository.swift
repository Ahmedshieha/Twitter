//
//  HomeRepository.swift
//  TwitterTask
//
//  Created by Reda on 02/05/2024.
//

import Combine

protocol HomeRepositoryProtocol: AnyObject {
    func postTweet(_ tweetText: String) -> AnyPublisher<TweetsEntity, NetworkError>
}

final class HomeRepository: HomeRepositoryProtocol {
    
    private let remoteDSk: HomeRemoteDataSourceProtocol
    
    init(remoteDSk: HomeRemoteDataSourceProtocol = HomeRemoteDataSource()) {
        self.remoteDSk = remoteDSk
    }
    
    func postTweet(_ tweetText: String) -> AnyPublisher<TweetsEntity, NetworkError> {
        remoteDSk.postTweet(text: tweetText)
    }
}
