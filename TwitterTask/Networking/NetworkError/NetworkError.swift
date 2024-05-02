//
//  NetworkError.swift
//  TwitterTask
//
//  Created by Reda on 02/05/2024.
//

import Foundation

struct NetworkError: LocalizedError, Decodable {
    var message: String?
    var specificError: DefaultErrors?
    
    init(errorType: DefaultErrors) {
        self.specificError = errorType
    }
}

enum DefaultErrors: Decodable {
    case invalidResponse
    case serverError
    case decodingError
    case unknownError
    
    var errorDescription: String? {
        switch self {
        case .serverError:
            return "Unfortunately Server error!, try again later"
        case .unknownError:
            return "Unfortunately, SomeThing went wrong"
        case .invalidResponse:
            return "There is error occurred , try again later"
        case .decodingError:
            return "Failed to decoded data received from server"
        }
    }
}
