//
//  HomeViewModel.swift
//  TwitterTask
//
//  Created by Reda on 02/05/2024.
//

import Combine

@MainActor
protocol HomeViewModelProtocol: AnyObject {
    var isLoading: CurrentValueSubject<Bool, Never> { get }
    var showMessage: PassthroughSubject<String, Never> { get }
    
    func postTweet(_ tweetText: String) async
}

final class HomeViewModel: HomeViewModelProtocol {
    
    private(set) var isLoading: CurrentValueSubject<Bool, Never> = .init(false)
    private(set) var showMessage: PassthroughSubject<String, Never> = .init()
    
    private let useCase: HomeUseCaseProtocol
    
    init(useCase: HomeUseCaseProtocol = HomeUseCase()) {
        self.useCase = useCase
    }
    
    func postTweet(_ tweetText: String) async {
        isLoading.send(true)
        let requestResult = await useCase.postTweet(tweetText)
        isLoading.send(false)
        
        switch requestResult {
        case .success(let data):
            showMessage.send("Tweeted 🎉")
        case .failure(let error):
            showMessage.send(error.localizedDescription)
        }
    }
}
