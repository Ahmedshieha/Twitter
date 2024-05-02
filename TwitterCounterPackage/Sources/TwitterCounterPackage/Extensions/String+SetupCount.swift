//
//  String+SetupCount.swift
//
//
//  Created by Reda on 02/05/2024.
//

import UIKit

extension String {
    
    var getURLCount: Int {
        let urls = self.components(separatedBy: .whitespacesAndNewlines)
            .compactMap { URL(string: $0) }
            .filter { $0.scheme == "http" || $0.scheme == "https" }
        
        let count = urls.reduce(0) { result, url in
            let urlString = url.absoluteString.removingPercentEncoding ?? ""
            let urlLength = min(23, urlString.count)
            return result + urlLength
        }
        
        return max(0, count)
    }
    
    var charactersCount: Int {
        return self.reduce(0) { count, character in
            let charCount = character.isEmoji ? 2 : (character == " " ? 1 : 1)
            return count + charCount
        }
    }
    
    var countMentionsInTweet: Int {
        let mentionRegex = try! NSRegularExpression(pattern: "@\\w+")
        let mentions = mentionRegex.matches(in: self, range: NSRange(self.startIndex..., in: self))
        return mentions.count
    }
    
    var separateURLFromText: (String, String) {
        var url = ""
        var otherCharacters = ""
        
        guard let regex = try? NSRegularExpression(pattern: Constants.urlPattern, options: .caseInsensitive) else {
            return (url, otherCharacters)
        }
        
        let matches = regex.matches(in: self, options: [], range: NSRange(location: 0, length: self.utf16.count))
        
        if let match = matches.first, let range = Range(match.range, in: self) {
            url = String(self[range])
            otherCharacters = self.replacingOccurrences(of: url, with: "")
            otherCharacters = otherCharacters.trimmingCharacters(in: .whitespacesAndNewlines)
        } else {
            otherCharacters = self.trimmingCharacters(in: .whitespacesAndNewlines)
        }
        
        return (url, otherCharacters)
    }
}
