//
//  NSAttributedStringExtensions.swift
//  TinyConsole
//
//  Created by Devran on 30.09.19.
//

import Foundation

internal extension NSAttributedString {
    static func breakLine() -> NSAttributedString {
        return NSAttributedString(string: "\n")
    }
    
    var range: NSRange {
        return NSRange(location: 0, length: length)
    }
}
