//
//  HomeViewController.swift
//  TwitterTask
//
//  Created by Reda on 30/04/2024.
//

import UIKit
import Combine
import TwitterCounterPackage

final class HomeViewController: BaseViewController {

    @IBOutlet private weak var counterView: TwitterCounterView!
    
    private var cancellable = Set<AnyCancellable>()
    
    private lazy var viewModel: HomeViewModelProtocol = {
        HomeViewModel()
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
    }
    
    private func setupViews() {
        bindUI()
        counterView.delegate = self
    }
}

extension HomeViewController : TwitterCounterViewProtocol {
    
    func postTweet(text: String) {
        postTweet(text)
    }
}

private extension HomeViewController {
    
    func bindUI() {
        bindLoading()
        bindShowMessage()
    }
    
    func bindLoading() {
        viewModel.isLoading.sink { [weak self] status in
            guard let self else { return }
            status ? startLoading() : stopLoading()
        }.store(in: &cancellable)
    }
    
    func bindShowMessage() {
        viewModel.showMessage.sink { [weak self] message in
            guard let self else { return }
            showAlert(self, message: message)
        }.store(in: &cancellable)
    }
    
    func postTweet(_ tweetText: String) {
        Task {
            await viewModel.postTweet(tweetText)
        }
    }
}
