//
//  EndPoints.swift
//  TwitterTask
//
//  Created by Reda on 02/05/2024.
//

import Foundation

enum Endpoints: RequestBase {
    
    var parameter: [String : String]? {
        switch self {
        case .postTweet(let tweet):
            return ["status": tweet]
        }
    }
    
    // MARK: - Properties
    case postTweet(tweet: String)
    
    // MARK: - Path
    var path: String {
        switch self {
        case.postTweet:
            return "1.1/statuses/update.json?"
        }
    }
}
