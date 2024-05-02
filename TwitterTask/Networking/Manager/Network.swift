//
//  Network.swift
//  TwitterTask
//
//  Created by Reda on 02/05/2024.
//

import Combine

protocol Network {
    func execute<T: Codable>(_ request: RequestBase, model: T.Type) -> AnyPublisher<T, NetworkError>
}
