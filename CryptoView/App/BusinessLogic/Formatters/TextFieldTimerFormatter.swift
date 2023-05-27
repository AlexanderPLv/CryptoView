//
//  TextFieldTimerFormatter.swift
//  CryptoView
//
//  Created by Alexander Pelevinov on 22.05.2023.
//

import UIKit

protocol TextFieldFormatter {
    func format(_ text: String) -> String?
    func fillEndWithMask(_ string: String) -> String
    func removeMask(_ text: String) -> String
}

final class TimerFormatter: TextFieldFormatter {

    private let mask = "  :  "
    private let parser: TimerParser
    
    init(parser: TimerParser) {
        self.parser = parser
    }
    
    func format(_ text: String) -> String? {
        let numbers = text.components(
            separatedBy: CharacterSet.decimalDigits.inverted
        ).joined()
        
        var result = ""
        var index = numbers.startIndex
        for ch in mask {
            if index == numbers.endIndex {
                break
            }
            if ch == " " {
                result.append(numbers[index])
                index = numbers.index(after: index)
            } else {
                result.append(ch)
            }
        }
        return result
    }
    
    func fillEndWithMask(_ string: String) -> String {
        var text = string
        var count = text.count
        
        let mask = mask as NSString
        while (count < mask.length) {
            let unichar = mask.character(at: count)
            let unicharString = Character(UnicodeScalar(unichar)!)
            text.append(unicharString)
            count += 1
        }
        return text
    }
    
    func removeMask(_ text: String) -> String {
        return text
    }
}


