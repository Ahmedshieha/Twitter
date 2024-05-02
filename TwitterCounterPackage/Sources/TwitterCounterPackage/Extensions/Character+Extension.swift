//
//  Character+Extension.swift
//
//
//  Created by Reda on 02/05/2024.
//

import UIKit

extension Character {
    
    var isEmoji: Bool {
        guard let scalar = self.unicodeScalars.first else { return false }
        
        for range in emojiRanges {
            if range.contains(scalar.value) {
                return true
            }
        }
        
        return false
    }
}

private extension Character {
    var emojiRanges: [ClosedRange<UInt32>] {
        [
            0x1F600...0x1F64F,
            0x1F300...0x1F5FF,
            0x1F680...0x1F6FF,
            0x1F900...0x1F9FF,
            0x2600...0x26FF,
            0x2700...0x27BF,
            0xFE00...0xFE0F,
            0x1F1E6...0x1F1FF
        ]
    }
}
