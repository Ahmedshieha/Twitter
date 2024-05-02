//
//  TwitterCounterViewModel.swift
//
//
//  Created by Reda on 01/05/2024.
//

import Foundation

protocol TwitterCounterViewModelProtocol {
    func tweetCount(with text: String) -> Int
    func validateTweetCount(_ tweet: String) -> Bool
}

final class TwitterCounterViewModel: TwitterCounterViewModelProtocol {
    
    func tweetCount(with tweetText: String) -> Int {
        let (url, otherCharacters) = tweetText.separateURLFromText
        let urlCount = url.getURLCount
        let mentionCount = tweetText.countMentionsInTweet
        let characterCount = otherCharacters.charactersCount
        let totalCount = urlCount + mentionCount + characterCount
        return totalCount
    }
    
    func validateTweetCount(_ tweet: String) -> Bool {
        tweetCount(with: tweet) <= 280
    }
}
