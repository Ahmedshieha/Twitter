//
//  HomeUseCase.swift
//  TwitterTask
//
//  Created by Reda on 02/05/2024.
//

import Combine

protocol HomeUseCaseProtocol: AnyObject {
    func postTweet(_ tweetText: String) async -> Result<TweetsEntity , NetworkError>
}

final class HomeUseCase: HomeUseCaseProtocol {
    
    private let repository: HomeRepositoryProtocol
    private var cancellable = Set<AnyCancellable>()
    
    init(repository: HomeRepositoryProtocol = HomeRepository()) {
        self.repository = repository
    }
    
    func postTweet(_ tweetText: String) async -> Result<TweetsEntity , NetworkError> {
        await repository.postTweet(tweetText).singleOutput(with: &cancellable)
    }
}
