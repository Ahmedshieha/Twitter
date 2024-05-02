//
//  NetworkConstants.swift
//  TwitterTask
//
//  Created by Reda on 02/05/2024.
//

import Foundation
import CommonCrypto

struct Constants {
   
  static var baseURL = "https://api.twitter.com/"
  static var apiKey = "x7O0lE9VfKXBtmbxjNNMcKAGO"
  static var apiSecret = "0LbAk6bmU29NERgrti0nT12ljZo6aSlUFqvivYPLefsDtvgR1q"
  static var accessToken = "1417775793896398850-RPykwW7vUzOaS954lAXIekC0e4Yu8O"
  static var accessTokenSecret = "v6YIWlJihvGL5r1WqL87WSTixsxCl56EqN5eEFLBDeGGZ"
}

extension RequestBase {
    
    var scheme: String {
        return "https"
    }
    
    var baseURL: String {
        return "https://api.twitter.com/"
    }
    
    var apiKey : String  {
       return "x7O0lE9VfKXBtmbxjNNMcKAGO"
    }
    var apiSecret: String {
        return "0LbAk6bmU29NERgrti0nT12ljZo6aSlUFqvivYPLefsDtvgR1q"
    }
    var accessToken : String {
        return  "1417775793896398850-RPykwW7vUzOaS954lAXIekC0e4Yu8O"
    }
    var accessTokenSecret: String {
        return  "v6YIWlJihvGL5r1WqL87WSTixsxCl56EqN5eEFLBDeGGZ"
    }
    
    var method: HTTPMethod {
        return .post
    }
    
    var headers: [String: String]? {
        return [
            "oauth_consumer_key": apiKey,
            "oauth_token": accessToken,
            "oauth_signature_method": "HMAC-SHA1",
            "oauth_timestamp": "\(Int(Date().timeIntervalSince1970))",
            "oauth_nonce": UUID().uuidString,
            "oauth_version": "1.0",
            "oauth_signature" : AuthSignature().generateSignature
        ]
    }

}

extension RequestBase {
    
    // MARK: URLRequest Generator
    //
    func asURLRequest() -> URLRequest {
        var component: URLComponents = URLComponents()
        component.scheme = self.scheme
        component.host = self.baseURL
        component.path = self.path

        if let parameter = self.headers {
            component.queryItems = parameter
                .map { URLQueryItem(name: $0.key, value: $0.value) }
        }

        var urlRequest = URLRequest(url: component.url ?? URL(fileURLWithPath: ""))
        urlRequest.httpMethod = self.method.rawValue
        self.headers?.forEach({
            urlRequest.setValue($0.value, forHTTPHeaderField: $0.key)
        })
        return urlRequest
    }
}
