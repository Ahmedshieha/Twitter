//
//  AuthSignature.swift
//  TwitterTask
//
//  Created by Reda on 02/05/2024.
//

import Foundation
import CommonCrypto

struct AuthSignature {
    
    func generateOAuthSignature(url: String,
                                method: String,
                                parameters: [String: String],
                                consumerSecret: String,
                                tokenSecret: String) -> String? {
        let sortedParams = parameters.sorted { $0.key < $1.key }
        let parameterString = sortedParams.map { "\($0.key)=\($0.value)" }.joined(separator: "&")
        let signatureBaseString = "\(method)&\(url.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)!)&\(parameterString.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)!)"

        let signingKey = "\(consumerSecret.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)!)&\(tokenSecret.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)!)"
        guard let signatureData = signatureBaseString.data(using: .utf8),
              let signingKeyData = signingKey.data(using: .utf8) else {
            return nil
        }
        
        var hmac = [UInt8](repeating: 0, count: Int(CC_SHA1_DIGEST_LENGTH))
        signatureData.withUnsafeBytes { signatureBuffer in
            signingKeyData.withUnsafeBytes { signingKeyBuffer in
                CCHmac(CCHmacAlgorithm(kCCHmacAlgSHA1),
                       signingKeyBuffer.baseAddress, signingKeyBuffer.count,
                       signatureBuffer.baseAddress, signatureBuffer.count,
                       &hmac)
            }
        }
        
        let signature = Data(hmac).base64EncodedString()
        return signature
    }
    
    var generateSignature: String {
        let consumerSecret = Constants.apiSecret
        let tokenSecret = Constants.accessTokenSecret
        let url = Constants.baseURL
        let method = "POST"
        let parameters = ["status": "Hello, Twitter!"]
        let signature = generateOAuthSignature(
            url: url,
            method: method,
            parameters: parameters,
            consumerSecret: consumerSecret,
            tokenSecret: tokenSecret
        )
        return signature ?? ""
    }

}
