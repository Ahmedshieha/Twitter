//
//  HomeRemoteDataSourceProtocol.swift
//  TwitterTask
//
//  Created by Reda on 02/05/2024.
//

import Combine

protocol HomeRemoteDataSourceProtocol {
    func postTweet(text: String) -> AnyPublisher<TweetsEntity , NetworkError>
}

struct HomeRemoteDataSource: HomeRemoteDataSourceProtocol {
 
    private let network: Network
    
    init(network: Network = NetworkManager()) {
        self.network = network
    }
    
    func postTweet(text: String) -> AnyPublisher<TweetsEntity, NetworkError> {
        let request = Endpoints.postTweet(tweet: text)
        let model = TweetsEntity.self
        let response = network.execute(request, model: model)
        return response
    }
}
